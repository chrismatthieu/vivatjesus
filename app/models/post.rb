class Post < ActiveRecord::Base
  belongs_to :user
  def self.per_page
    3
  end
end
