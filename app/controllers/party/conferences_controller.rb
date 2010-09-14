class Party::ConferencesController < ApplicationController
  respond_to :html, :json

  def show
    @conference = Party::Conference.find(params[:id])
    respond_with @session
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    flash[:error] = error.message
    redirect_to root_path
  end
end
