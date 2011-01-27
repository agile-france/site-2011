class CompaniesController < ApplicationController
  include ::Controllers::Search::Support
  before_filter :authenticate_user!, :only => [:destroy, :update]
  before_filter :authorize_user!, :only => [:destroy, :update]
  respond_to :html, :js, :json

  # XXX KISS
  cant do
    case params[:action].to_sym
    when :update
      not current_user.company == current_company
    when :destroy
      not current_user.admin?
    end
  end
  
  def index
    criteria = {}.tap {|hash| hash[:name] = params[:q] unless params[:q].blank?}
    @companies = search(Company, criteria)
    respond_to do |format|
      format.html {render @companies.paginate(pager_options)}
      format.json {render :json => @companies.to_a.to_json}
    end
  end
  
  def new
    @company = Company.new
    respond_with @company
  end
  
  def create
    @company = Company.new(params[:company])
    if @company.save
      redirect_to companies_path
    else
      render :new
    end
  end
  
  def show
    respond_with current_company
  end

  def destroy
    current_company.destroy
    redirect_to companies_path
  end
  
  def edit
    respond_with current_company
  end
  
  def update
    if current_company.update_attributes!(params[:company])
      flash[:notice] = t('company.update.success')
      redirect_to companies_path
    else
      render :edit
    end
  end
  
  private
  def current_company
    @company ||= Company.find(params[:id])
  end
  def pager_options
    {:page => params[:page], :per_page => params[:per_page] || 5}
  end
end
