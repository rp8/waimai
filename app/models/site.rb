class Site < ActiveRecord::Base
  has_many :users, :through => :memberships
  has_many :customers
  has_many :orders
  has_many :memberships

  def new_orders(limit=10)
    self.orders.find(:all, :limit => limit, :conditions => ["status = 'NEW'"])
  end

  def create_order2(order = {})
    order_id = last_order_id + 1
    self.update_attribute(:last_order_id, order_id)

    Order.transaction do
      o = Order.new(:site_id => id, :customer_id => order[:customer_id],
                :order_id => order_id, :status => 'new', :note => order[:note])
      o.save!
    end
  end

end
