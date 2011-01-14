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
        authentication.attributes = simplify(auth)
        authenticate_with! authentication
      else
        if (existing_user = User.identified_by_email(auth['user_info']['email']))
          authentication = existing_user.authentications.build(simplify(auth))
          authenticate_with! authentication
        else
          session[:auth] = simplify(auth)
          redirect_to new_user_registration_path
        end
      end
    end
    
    private
    def authenticate_with!(authentication)
      authentication.activate.save!
      sign_in_and_redirect(:user, authentication.user)
    end
    def simplify(hash)
      hash.except('credentials', 'extra')
    end
  end
end