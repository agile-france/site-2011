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
  
  # cancan does not integrate with mongoid
  # see https://github.com/ryanb/cancan/pull/172
  # so crafted an authorization library, named cant
  include Cant::Embeddable
  die {raise Cant::AccessDenied, I18n.translate('resources.not_authorized')}
  helper_method :cant?
  alias_method :authorize_user!, :die_if_cant!
  
  private
  rescue_from Mongoid::Errors::DocumentNotFound do |error|
    flash_and_log(:error, error.message)
    redirect_to root_path
  end

  rescue_from Cant::AccessDenied do |error|
    flash_and_log(:error, error.message)
    redirect_to request.referer
  end
  
  def flash_and_log(symbol, content)
    message = content.respond_to?(:message) ? content.message : content
    logger.send(symbol, message)
    flash[symbol] = message
  end
end
