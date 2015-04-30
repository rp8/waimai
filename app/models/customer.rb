class Customer < ActiveRecord::Base
  has_many :orders
  belongs_to :site

  def name
    first_name.to_s + ' ' + last_name.to_s
  end

end
