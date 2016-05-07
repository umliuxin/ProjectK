class User < ActiveRecord::Base
  attr_accessor :remember_token

  before_save {self.name = name.downcase}
  validates :name, presence: true, length: { maximum: 50 },uniqueness: {case_sensitive:false}

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, remember_token)
  end

  def authtoken?(remember_token)
    self.remember_digest == remember_token
  end
end
