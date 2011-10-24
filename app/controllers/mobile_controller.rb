class MobileController < ApplicationController
  before_filter :current_council  
  layout :false

end
