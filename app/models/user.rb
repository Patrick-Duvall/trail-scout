class User < ApplicationRecord
  has_secure_password
  has_many :searches, :foreign_key => "api_key", :class_name => "TrailSearch"

  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email, with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i
  validates :password_digest, presence: true
  validates_length_of :password, :in => 6..20, :on => :create
  after_create :add_api_key

  # attr_accessor :email, :password, :api_key

  private
  def add_api_key
    self.update(api_key: SecureRandom.hex)
  end
end