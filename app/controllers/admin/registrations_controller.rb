module Admin
  class RegistrationsController < ::Admin::Base
    respond_to :html
    
    def index
      @registrations = Registration.all()
    end
    
  end
end
