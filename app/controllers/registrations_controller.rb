class RegistrationsController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user!, :except => [:assign]
  before_filter :load_conference, :only => [:new, :create]
  before_filter :load_registration, :only => [:edit, :update, :search]

  cant do |action, registration|
    if action == :assign
      not current_user.admin? unless registration.invoice.user == current_user
    end
  end

  def new
    onoes :service_unavailable
  end

  def create
    onoes :service_unavailable
  end

  def update
    if @registration.update_attributes(params[:registration])
      redirect_to registrations_account_path
    else
      render :edit
    end
  end

  def edit
  end

  def search
    @users = params[:q] ? User.where(:email => %r{#{params[:q]}}i) : User.all
    @users = @users.select {|u| not u.registered_to?(@registration.product)}
    respond_with(@users)
  end

  def assign
    registration = Registration.find(params[:registration_id])
    registration.update_attributes(:user_id => params[:user_id]) unless die_if_cant!(:update, registration)
    redirect_to registrations_account_path
  end

  private
  def load_registration
    @registration = Registration.find(params[:id])
  end
  def load_conference
    @conference ||= Conference.find(params[:conference_id])
  end
  def onoes(status)
    render text: status.to_s.humanize, status: status
  end
end
