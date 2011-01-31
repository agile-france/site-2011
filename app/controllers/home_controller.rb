class HomeController < ApplicationController
  def index
    redirect_to conferences_path
  end
  def version
    render :text => `git log -1`
  end
end
