module Auth
  class SessionsController < Devise::SessionsController
    def destroy
      u = current_user
      super
      u.authentications.activated?.each {|a| a.deactivate!} if u
    end
  end
end