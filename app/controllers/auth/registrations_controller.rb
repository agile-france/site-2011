module Auth
  class RegistrationsController < Devise::RegistrationsController
    # XXX there is a security issue here
    # a twitter authentication can be used to log on once with any existing account (by entering its email)
    def create
      # using authentication without email, and typed in email exists ...
      if session[:auth] && User.identified_by_email(params[:user][:email])
        session[:auth]['email'] = params[:user][:email]
        redirect_to new_session_path(:user)
      else
        super
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