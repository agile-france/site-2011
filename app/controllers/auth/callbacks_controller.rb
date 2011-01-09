module Auth
  class CallbacksController < Devise::OmniauthCallbacksController
    def twitter
      auth = request.env['omniauth.auth']
      auth_info = {:provider => auth['provider'], :uid => auth['uid']}
      authentication = Authentication.where(auth_info).first
      if authentication
        sign_in_and_redirect(:user, authentication.user)
      else
        user = User.new(auth['user_info'])
        user.authentications.build(auth_info)
        if user.save
          redirect_to root_path
        else
          session[:auth] = auth.except('credentials', 'extra')
          redirect_to new_user_registration_path
        end
      end
    end
  end
end