class Activity < ActiveRecord::Base
  attr_accessible :follow_id, :message, :register_id, :status_id, :user_id
  has_many :statuses
  has_many :contacts
  belongs_to :user
end
