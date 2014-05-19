# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50, minimun: 1}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 1024, minimun: 1},
             format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }
end
