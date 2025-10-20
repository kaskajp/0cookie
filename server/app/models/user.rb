class User < ApplicationRecord
  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :workspaces, through: :memberships

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^\s@]+@[^\s@]+\z/ }
end
