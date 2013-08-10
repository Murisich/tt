# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_secure_password
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  has_many :microposts, dependent: :destroy

  validates :name,  presence: true, length: { minimum: 6, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  					format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true      

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end            
end
