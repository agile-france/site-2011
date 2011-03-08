class RegistrationsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  
  def new
    matcher = Matcher.new
    @orders = current_conference.best_offers.map{|o| matcher.opposite(o)}
  end
  
  def create
    orders = params[:orders].select{|o| o[:checked]}.map do |o|
      Order.create(o.delete_if{|k,_v| k.to_sym == :checked}.merge(:user => current_user))
    end
    redirect_to current_conference, :notice => t('registrations.new!')
  end
  
  def current_conference
    @conference ||= Conference.find(params[:conference_id])
  end
end
