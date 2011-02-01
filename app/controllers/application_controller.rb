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
  die {raise Cant::AccessDenied, I18n.translate('authorization.access_denied')}
  helper_method :cant?
  alias_method :authorize_user!, :die_if_cant!
  
  # seems to have a bug within [will_paginate, mongoid]
  # - not providing :per_page option cause unfunctional pager in view (Previous is unreachable)
  # - per_page is not looked in underlying model
  def pager_options(model=nil)
    per_page = (model && model.respond_to?(:per_page)) ? model.send(:per_page) : 25
    {:page => params[:page], :per_page => params[:per_page] || per_page}
  end  
  
  protected
  def highlight(key, value_or_default_value='', &block)
    flash[key] = (block.nil?? value_or_default_value : yield(flash[key] ||= value_or_default_value))
  end

  def flash_and_log(symbol, content)
    message = content.respond_to?(:message) ? content.message : content
    logger.send(symbol, message)
    highlight(symbol, message)
  end  

  def after_sign_in_path_for(resource_or_scope)
    edit_account_path
  end

  # rescues
  # 
  rescue_from Mongoid::Errors::DocumentNotFound do |error|
    flash_and_log(:error, error.message)
    redirect_to root_path
  end

  rescue_from Cant::AccessDenied do |error|
    flash_and_log(:error, error.message)
    redirect_to request.referer
  end
end
