module Admin
  class UsersController < ApplicationController
    respond_to :html
    
    def index
      @users = User.all
    end
    
    def edit
      @user = User.find(params[:id])
    end

    def update
      user = User.find(params[:id])
      if user.tap {|u| u.admin = params[:admin]}.save
        flash[:notice] = t('update.success!', user)
      end
      respond_with user, :location => admin_users_path
    end
  end
end
