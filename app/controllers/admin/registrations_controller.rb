module Admin
  class RegistrationsController < ::Admin::Base
    respond_to :html
    
    def index
      criteria = {}
      @registrations = Registration.all()
    end
    
  end
end
