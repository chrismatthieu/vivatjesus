class Council < ActiveRecord::Base
  has_many :users
  has_many :payments
  has_many :activities
end
