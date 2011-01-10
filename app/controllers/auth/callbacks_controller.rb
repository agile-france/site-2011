module Auth
  class CallbacksController < Devise::OmniauthCallbacksController
    Devise.omniauth_configs.each do |provider, _config|
      module_eval <<-EOS
        def #{provider}; authorize; end
      EOS
    end
    
    private
    def authorize
      auth = request.env['omniauth.auth']
      auth_info = {:provider => auth['provider'], :uid => auth['uid']}
      authentication = Authentication.where(auth_info).first
      if authentication
        sign_in_and_redirect(:user, authentication.user)
      else
        user = User.where(:email => auth['user_info']['email']).first || User.new(auth['user_info'])
        authentication = user.authentications.build(auth_info)
        if user.save && authentication.save
          sign_in_and_redirect(:user, user)
        else
          session[:auth] = auth.except('credentials', 'extra')
          redirect_to new_user_registration_path
        end
      end
    end
  end
end