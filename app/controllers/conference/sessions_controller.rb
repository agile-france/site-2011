class Conference::SessionsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def new
  end

  def create
    @product = Session.new(params[:session])
    respond_with @product, :location => root_path
  end
end
