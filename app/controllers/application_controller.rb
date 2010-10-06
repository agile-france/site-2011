class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  prepend_before_filter :localize
  def localize
    I18n.locale = session[:locale] = params[:locale]
    logger.debug("using provided locale #{I18n.locale}") if params[:locale]
  end

  def default_url_options
    options = {}
    options[:locale] = session[:locale] if session[:locale]
    options
  end
  
  rescue_from Mongoid::Errors::DocumentNotFound do |error|
    flash[:error] = error.message
    redirect_to root_path
  end

  rescue_from Failures::AccessDenied do |failure|
    flash[:error] = failure.message
    redirect_to :back
  end
end
