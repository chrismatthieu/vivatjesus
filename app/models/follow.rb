class Follow < ActiveRecord::Base
  attr_accessible :block_id, :follow_id, :user_id
  belongs_to :user
end
