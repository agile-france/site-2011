module Admin
  class Base < ApplicationController
    before_filter :authenticate_admin!
    load_and_authorize_resource

    private
    def authenticate_admin!
      user = authenticate_user!
      raise CanCan::AccessDenied unless user.admin?
    end
  end
end
