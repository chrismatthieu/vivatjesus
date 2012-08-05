class Council < ActiveRecord::Base
  has_many :users
  has_many :payments
end
