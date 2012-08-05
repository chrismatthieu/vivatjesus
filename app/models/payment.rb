class Payment < ActiveRecord::Base
  attr_accessible :council_id, :description, :paypalcode, :promoactive, :title
  belongs_to :council
end
