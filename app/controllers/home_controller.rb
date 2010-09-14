class HomeController < ApplicationController
  def index
    redirect_to conferences_path
  end
end
