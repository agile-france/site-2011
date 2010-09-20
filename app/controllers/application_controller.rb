class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  rescue_from ActiveRecord::RecordNotFound do |error|
    flash[:error] = error.message
    redirect_to root_path
  end
end
