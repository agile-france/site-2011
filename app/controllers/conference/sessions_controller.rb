class Conference::SessionsController < ApplicationController
  respond_to :html, :json

  def new
  end

  def create
    @product = Session.new(params[:session])
    respond_with @product, :location => root_path
  end
end
