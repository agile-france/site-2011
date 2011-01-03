class AdminController < ApplicationController
  before_filter :authenticate_user!, :authorize_user!
  cant do
    not current_user.admin?
  end
  
  def show
  end
end
