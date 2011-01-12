module Auth
  class SessionsController < Devise::SessionsController
    def create
      super
      if session['auth']
        current_user.authentications.create!(session['auth'])
      end
    end
    
    def destroy
      u = current_user
      super
      u.authentications.activated?.each {|a| a.deactivate.save} if u
    end
    
    protected
    def build_resource(hash=nil)
      super
      resource.email=session['auth']['email'] if session['auth']
    end
  end
end