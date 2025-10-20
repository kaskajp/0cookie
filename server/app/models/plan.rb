class Plan < ApplicationRecord
  has_many :subscriptions, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true
end


