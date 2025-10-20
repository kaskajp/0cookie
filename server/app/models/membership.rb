class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :workspace

  ROLES = %w[admin member viewer].freeze

  validates :role, presence: true, inclusion: { in: ROLES }
end
