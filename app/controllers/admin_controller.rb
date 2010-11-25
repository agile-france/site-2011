class AdminController < ApplicationController
  before_filter :authorize_user!
  def show
  end
  
  def authorize_user!
    raise Failures::AccessDenied.new(t('resources.not_authorized')) unless can? :edit, User
  end
end
