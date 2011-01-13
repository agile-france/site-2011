class AccountController < ApplicationController
  before_filter :authenticate_user!
  
  def edit
    @user = current_user
  end
  
  def update
    current_user.tap do |user|
      user.attributes = params[:user]
      user.optins = (params[:optins] ? params[:optins].keys : [])
    end.save
    redirect_to edit_account_path
  end
  
  def destroy
    current_user.destroy
    redirect_to root_path
  end
end
