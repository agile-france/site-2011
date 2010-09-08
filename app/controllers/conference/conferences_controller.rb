class Conference::ConferencesController < ApplicationController
  def show
    @conference = Conference.where(:name => params[:name]).where(:edition => params[:edition]).first
    if @conference
      render
    else
      flash[:notice] = t('resources.not_found', :model => Conference, :params => params)
      redirect_to root_path
    end
  end
end
