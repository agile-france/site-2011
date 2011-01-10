module Auth
  class RegistrationsController < Devise::RegistrationsController
    def create
      super
      session[:auth]=nil if resource.persisted?
    end
    protected
    def build_resource(hash=nil)
      super
      if session[:auth]
        resource.attributes = session[:auth]['user_info']
        resource.authentications.build(session[:auth].except('user_info'))
        resource.valid?
      end
      resource
    end
  end
end