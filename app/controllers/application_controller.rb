class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  prepend_before_filter :localize
  def localize
    user_locale = params['locale'].to_sym if params['locale']
    I18n.locale = user_locale if user_locale
    logger.debug("using locale #{I18n.locale}")
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    flash[:error] = error.message
    redirect_to root_path
  end

  rescue_from Failures::AccessDenied do |failure|
    flash[:error] = failure.message
    redirect_to :back
  end
end
