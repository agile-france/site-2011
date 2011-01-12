module Auth
  class RegistrationsController < Devise::RegistrationsController
    # XXX there is a security issue here
    # a twitter authentication can be used to log on once with any existing account (by entering its email)
    def create
      if session[:auth] && (self.resource = User.with_email(params[:user][:email]).first)
        with_new_authentication(resource) {|_r, auth| auth.save!}
        sign_in_and_redirect(:user, resource)
      else
        super
      end
      session[:auth]=nil if resource.persisted?
    end
    
    protected
    def build_resource(hash=nil)
      super
      if session[:auth]
        resource.attributes = session[:auth]['user_info']
        with_new_authentication(resource) {|r, _auth| r.valid?}
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