class ConferencesController < ApplicationController
  respond_to :html, :json

  def recent
    @conference = Conference.all.desc(:updated_at).first
    if @conference
      @sessions = @conference.sessions.paginate(pager_options)
      render :show
    else
      @conferences = Conference.all
      render :index
    end
  end

  def index
    @conferences = Conference.all
    respond_with @conferences.paginate(pager_options)
  end

  def show
    @conference = Conference.find(params[:id])
    @sessions = @conference.sessions.paginate(pager_options)
    respond_with @conference
  end
  
  private
  def pager_options
    {:page => params[:page], :per_page => params[:per_page] || 5}
  end  
end
