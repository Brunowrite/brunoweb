class User < ApplicationRecord
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_secure_password
    validates :password, length: { minimum: 5, message: "A senha deve contém no monímo 6 dígitos" }
  end
