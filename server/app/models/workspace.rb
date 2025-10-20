class Workspace < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :websites, dependent: :destroy

  validates :name, presence: true
end
