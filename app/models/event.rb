class Event < ActiveRecord::Base
  has_event_calendar
  belongs_to :user
  def self.per_page
    3
  end
end
