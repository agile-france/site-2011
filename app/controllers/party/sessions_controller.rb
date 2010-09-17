class Party::SessionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :json

  def new
    @session = Party::Session.new
    respond_with @session
  end

  def create
    @session = Party::Session.new(params[:party_session])
    current_user.propose(@session, current_conference)
    flash[:notice] = t('party.session.new.success!') if @session.save
    respond_with @session, :location => conference_sessions_path(@conference)
  end

  def show
    @session = Party::Session.find(params[:id])
    respond_with @session
  end

  def edit
    @session = Party::Session.find(params[:id])
  end

  def update
    @session = Party::Session.find(params[:id])
    flash[:notice] = t('party.session.update.success!') if @session.update_attributes(params[:party_sessions])
    respond_with @session, :location => conference_session_path(@session)
  end

  def index
    @sessions = current_conference.sessions
    respond_with @sessions
  end

  private
  def current_conference
    @conference = Party::Conference.find(params[:conference_id])
  end
end
