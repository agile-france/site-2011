module Admin
  class UsersController < ::Admin::Base
    include ::Controllers::Search::Support
    respond_to :html
    
    def index
      criteria = {}
      criteria[:email] = params[:q] unless params[:q].blank?
      @users = search(User, criteria).order_by(:email.asc).paginate(pager_options)
    end
    
    def edit
      @user = User.find(params[:id])
    end

    def update
      user = User.find(params[:id])
      if user.tap {|u| u.admin = params[:user][:admin]}.save
        flash[:notice] = t('update.success', user)
      end
      respond_with user, :location => admin_users_path
    end
  end
end
