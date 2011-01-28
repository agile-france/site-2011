module Auth
  class RegistrationsController < Devise::RegistrationsController
    def create
      # using authentication without email, and typed in email exists ...
      if session[:auth] && User.identified_by_email(params[:user][:email])
        session[:auth]['email'] = params[:user][:email]
        redirect_to new_session_path(:user), :notice => t('auth.accept_authentication?')
      else
        super
        highlight(:notice) do |notice|
          notice = "* #{notice}\n"
          notice << "* " << t('account.introduce', :url => edit_account_path)
        end
        session[:auth]=nil
      end
    end
    
    protected
    def build_resource(hash=nil)
      build_optins(build_authentication(super))
    end
    
    private
    def build_authentication(resource)
      if session[:auth]
        resource.attributes = session[:auth]['user_info']
        resource.authentications.build(session[:auth])
        resource.ensure_password_not_blank!
        resource.valid?
      end
      resource
    end
    def build_optins(resource)
      resource.optins = (params[:optins] ? params[:optins].keys : [])
    end
  end
end