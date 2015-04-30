class OrdersController < ApplicationController

  def index
    @site ||= Site.find(params[:site_id])
    @new_orders = @site.orders.find(:all, :conditions => ['status = ?', 'new'],
                                   :order => 'order_id desc')
    @old_orders = @site.orders.find(:all, :limit => 10, 
                                    :conditions => ['status <> ?', 'new'],
                                    :order => 'updated_at desc')
  end

  def show
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @site = @customer.site
    @order = @site.orders.build(:customer_id => @customer.id)
  end

  def edit
    @site = Site.find(params[:site_id])
    @order = @site.orders.find(params[:id])
  end

  def create
    @site = Site.find(params[:site_id])
    @order = @site.create_order2(params[:order])
    redirect_to site_orders_url(@site)
  end

  def update
    @site = Site.find(params[:site_id])
    @order = @site.orders.find(params[:id])
    if params[:status]
      @order.update_attribute(:status, params[:status])
    else
      @order.update_attributes(params[:order]);
    end
  end

  def destroy
  end

  protected


end

