class User < ActiveRecord::Base
  # attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password
  # validates_uniqueness_of :username, :on => :create  
  validates :username, :presence =>true,
                      :uniqueness=>true, :on => :create 
  validates :fullname, :presence =>true,
                      :uniqueness=>true, :on => :create 
  validates :email, :presence =>true,
                      :uniqueness=>true, :on => :create 
  validates :password, :presence =>true,
                      :length => { :minimum => 5, :maximum => 40 },
                      :confirmation =>true, :on => :create 
  has_many :posts
  has_many :events
  belongs_to :council
  has_many :follows
  has_many :statuses
  has_many :activities

  before_create { generate_token(:auth_token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver rescue ""
  end

end
