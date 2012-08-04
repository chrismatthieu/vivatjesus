class Status < ActiveRecord::Base
  attr_accessible :location, :message, :mylat, :mylong, :user_id
  attr_protected :twitter
  attr_protected :facebook
  
  belongs_to :user
  belongs_to :activity
end
