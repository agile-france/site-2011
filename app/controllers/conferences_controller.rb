class ConferencesController < ApplicationController
  respond_to :html, :json

  def recent
    if sort_and_paginate Conference.all.desc(:updated_at).first
      render :show
    else
      @conferences = Conference.all
      render :index
    end
  end

  def index
    @conferences = Conference.all
    respond_with @conferences.page(params[:page])
  end

  def show
    respond_with sort_and_paginate(Conference.find(params[:id]))
  end

  private
  def sort_and_paginate(conference)
    conference.tap {|c| @conference = c; @sessions = c.sessions.desc(:updated_at).page(params[:page]) if c}
  end
end
