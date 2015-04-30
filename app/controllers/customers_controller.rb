class CustomersController < ApplicationController

  def index
    @customers = Site.find(params[:site_id]).customers.find(:all, :limit => 10)
  end

  # Ajax: find by phone
  def find
    @phone = params[:phone]
    @site = Site.find(params[:site_id])
    @customers = @site.customers.find(:all, :limit => 10, :order => 'phone asc',
          :conditions => ['phone LIKE ?', @phone + '%']) unless @phone == ''

    render :layout => false
  end

  def new
    @site = Site.find(params[:site_id])
    @customer = @site.customers.build(:phone => params[:phone])
  end

  # Ajax
  def create
    @site = Site.find(params[:site_id])
    @customer = @site.customers.create(params[:customer]) if params[:customer]
    render :layout => false
  end

  def show
  end

  def edit
    @customer = find_customer
  end

  # Ajax: update a customer
  def update
    @customer = find_customer
    @customer.update_attributes!(params[:customer]) if @customer

    render :layout => false
  end

  def destroy
  end

  protected

  def find_customer
    @customer = Customer.find(:first, :conditions => ['site_id = ? AND id = ?', 
                              params[:site_id], params[:id]])
  end

end

