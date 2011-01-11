module Auth
  class CallbacksController < Devise::OmniauthCallbacksController
    Devise.omniauth_configs.each do |provider, _config|
      module_eval <<-EOS
        def #{provider}; authorize!; end
      EOS
    end
    
    private
    def authorize!
      auth = request.env['omniauth.auth']
      key = {:provider => auth['provider'], :uid => auth['uid']}
      authentication = Authentication.where(key).first
      if authentication
        authentication.update_attributes!(simplify(auth))
        authenticate_with! authentication
      else
        user = User.where(:email => auth['user_info']['email']).first || User.new(auth['user_info'])
        authentication = user.authentications.build(simplify(auth))
        if user.save && authentication.save!
          authenticate_with! authentication
        else
          session[:auth] = simplify(auth)
          redirect_to new_user_registration_path
        end
      end
    end
    
    private
    def authenticate_with!(authentication)
      authentication.update_attributes! :activated => true
      sign_in_and_redirect(:user, authentication.user)
    end
    def simplify(hash)
      hash.except('credentials', 'extra')
    end
  end
end