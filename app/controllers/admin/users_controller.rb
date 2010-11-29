module Admin
  class UsersController < ApplicationController
    respond_to :html
    
    def index
      @users = search(User).order_by(:email.asc).paginate(pager_options)
    end
    
    def edit
      @user = User.find(params[:id])
    end

    def update
      user = User.find(params[:id])
      if user.tap {|u| u.admin = params[:user][:admin]}.save
        flash[:notice] = t('update.success!', user)
      end
      respond_with user, :location => admin_users_path
    end
    
    private
    def pager_options
      {:page => params[:page], :per_page => params[:per_page] || 10}
    end
    
    def search(collection)
      return collection.all if params[:q].blank?
      pattern = ::Re.parse(params[:q]) || params[:q]
      collection.where(:email => pattern)
    end
  end
end
