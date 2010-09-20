class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  rescue_from ActiveRecord::RecordNotFound do |error|
    flash[:error] = error.message
    redirect_to root_path
  end

  rescue_from Failures::AccessDenied do |failure|
    flash[:error] = failure.message
    redirect_to :back
  end
end
