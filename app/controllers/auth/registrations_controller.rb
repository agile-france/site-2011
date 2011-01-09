module Auth
  class RegistrationsController < Devise::RegistrationsController
    def create
      super
      session[:auth]=nil if resource.persisted?
    end
    protected
    def build_resource(hash=nil)
      super
      resource.authentications.build(session[:auth].except('user_info')) if session[:auth]
    end
  end
end