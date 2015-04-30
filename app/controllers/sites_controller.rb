class SitesController < ApplicationController
  layout 'application'
  before_filter :login_required, :only => [:show, :new, :edit, :update]

  def index
  end

  def show
    if @site or current_user.site.id = params[:id]
      @site = Site.find(params[:id])
      @new_orders = @site.new_orders(10)
    else
      flash[:error] = "Invalid site"
    end
  end

  def new
    if current_user and current_user.site.nil?
      @site ||= Site.new
    end
  end

  def create
    begin
      if current_user and current_user.site.nil?
        @site = Site.new(params[:site])
        Site.transaction do 
          @site.save!
          @user = User.find(current_user.id)
          user_role = UserRole.new(:user_id => @user.id, :site_id => @site.id, :role_id => 1)
          if user_role.save
            flash[:notice] = "Site created"
            redirect_to sites_path(@site)
          end
        end
      end
    rescue Exception => ex
      flash[:error] = ex.message
    end
    render :action => :new
  end

  def edit

  end

  def update

  end

  def find_customer
    if params[:phone] == ''
      @customers = []
    else
      @customers = Customer.find(:all, :limit => 10, 
          :conditions => ['phone LIKE ?', params[:phone] + '%'])
    end

    render :layout => false
  end

end
