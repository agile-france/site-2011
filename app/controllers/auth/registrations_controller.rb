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
      super
      if session[:auth]
        resource.attributes = session[:auth]['user_info']
        with_new_authentication(resource) do |r, _auth|
          r.ensure_password_not_blank!
          r.valid?
        end
      end
      resource
    end
    def with_new_authentication(resource, &block)
      authentication = resource.authentications.build(session[:auth])
      return yield resource, authentication unless block.nil?
      [resource, authentication]
    end
  end
end