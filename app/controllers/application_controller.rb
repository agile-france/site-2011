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
  
  # uggh, what a smell to have this piece of code there
  # would take profit from a cancan device, provided it integrates with mongoid
  # see https://github.com/ryanb/cancan/pull/172
  def can?(perform, something)
    if current_user
      return true if current_user.admin?
      return true if current_user.sessions.include?(something)
    end
    false
  end
  
  private
  rescue_from Mongoid::Errors::DocumentNotFound do |error|
    flash_and_log(:error, error.message)
    redirect_to root_path
  end

  rescue_from Failures::AccessDenied do |error|
    flash_and_log(:error, error.message)
    redirect_to request.referer
  end
  
  def flash_and_log(symbol, content)
    message = content.respond_to?(:message) ? content.message : content
    logger.send(symbol, message)
    flash[symbol] = message
  end
end
