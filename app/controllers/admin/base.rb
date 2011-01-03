module Admin
  class Base < ApplicationController
    before_filter :authenticate_user!, :authorize_user!
    cant do
      not current_user.admin?
    end
  end
end
    