class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  prepend_before_filter :localize
  def localize
    if params[:locale]
      I18n.locale = session[:locale] = params[:locale]
    else
      session.delete(:locale)
      I18n.locale = I18n.default_locale
    end
  end

  def default_url_options
    session[:locale] ? {:locale => session[:locale]} : {}
  end

  # cancan does not integrate with mongoid
  # see https://github.com/ryanb/cancan/pull/172
  # so crafted an authorization library, named cant
  include Cant::Embeddable
  die {raise Cant::AccessDenied, I18n.translate('app.errors.access_denied')}
  helper_method :cant?
  def authorize_user!
    die_if_cant!(params[:action])
  end

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

  # rescues are strange ... https://rails.lighthouseapp.com/projects/8994/tickets/4444-can-no-longer-rescue_from-actioncontrollerroutingerror
  # from a testing point a view, dedicated middleware is appealing
  #
  [Mongoid::Errors::DocumentNotFound, Cant::AccessDenied].each do |problem|
    rescue_from(problem) do |error|
      rescue_with_appropriate_format_for(error)
    end
  end

  def rescue_with_appropriate_format_for(error)
    flash_and_log(:error, error.message)
    respond_to do |format|
      format.html {redirect_to request.referer || root_path }
      format.js {render 'shared/flash'}
    end
  end
end
