class AccountController < ApplicationController
  before_filter :authenticate_user!, :load_user
  
  def edit
  end
  
  def registrations
    orders = current_user.orders.desc(:created_at)
    @orders_by_conference = orders.reduce({}) do |acc, o|
      (acc[o.product.conference] ||= []) << o
      acc
    end
  end
  
  def sessions
    @sessions = current_user.sessions.desc(:created_at).paginate(pager_options)
  end
  
  def update
    flash[:notice] = t('account.updated!') if change_attributes(@user).save
    redirect_to edit_account_path unless request.xhr?
  end
  
  def destroy
    current_user.destroy
    redirect_to root_path
  end
  
  private
  def change_attributes(user)
    user.tap do |user|
      user.attributes = params[:user]
      user.optins = (params[:optins] ? params[:optins].keys : [])
      user.company = Company.identified_by_name(params[:company][:name]) if params[:company]
    end 
  end
  def load_user
    @user = current_user
  end
end
