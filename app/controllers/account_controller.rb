class AccountController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json
  
  def edit
    @user = current_user
  end
  
  def update
    current_user.tap do |user|
      user.attributes = params[:user]
      user.optins = (params[:optins] ? params[:optins].keys : [])
      user.company = Company.where(:name => params[:company][:name]).first if params[:company]
    end.save
    redirect_to edit_account_path
  end
  
  def destroy
    current_user.destroy
    redirect_to root_path
  end
end
