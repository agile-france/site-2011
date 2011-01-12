class AccountController < ApplicationController
  before_filter :authenticate_user!
  
  def edit
    @user = current_user
  end
  
  def update
    current_user.update_attributes!(params[:user])
    redirect_to edit_account_path
  end
  
  def destroy
    current_user.destroy
    redirect_to root_path
  end
end
