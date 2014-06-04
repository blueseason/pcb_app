# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50, minimum: 1}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 1024, minimum: 3},
             format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :mobile, presence: true, length: { is: 11 }, numericality: { only_integer: true },
             uniqueness: true

  validates :qq, presence: true, length: { minimum: 3 }
  validates :real_name, presence: true, length: { in: 1..20 }
  validates :address, presence: true, length: { in: 1..1024 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
