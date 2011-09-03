class CompaniesController < ApplicationController
  include ::Controllers::Search::Support
  before_filter :authenticate_user!, :only => [:destroy, :update, :new, :create]
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
    criteria = {}.tap{|hash| hash[:name] = params[:q] unless params[:q].blank?}
    companies = search(Company, criteria).asc(:name)
    if params[:pageless]
      respond_with(companies.to_a)
    else
      @companies = companies.page(params[:page])
      respond_with(@companies)
    end
  end

  def new
    @company = Company.new
    respond_with @company
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      current_user.tap{|u| u.company = @company}.save
      redirect_to(edit_account_path, :notice => t('company.created!',
        :user => current_user.greeter_name, :company => @company.name))
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
    current_company.update_attributes(params[:company]) ?
      redirect_to(companies_path, :notice => t('company.updated!')) : render(:edit)
  end

  private
  def current_company
    @company ||= Company.find(params[:id])
  end
end
