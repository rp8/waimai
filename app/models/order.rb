class Order < ActiveRecord::Base
  belongs_to :site
  belongs_to :customer

end
