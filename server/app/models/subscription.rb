class Subscription < ApplicationRecord
  belongs_to :workspace
  belongs_to :plan

  STATUSES = %w[active trialing past_due canceled].freeze

  validates :status, inclusion: { in: STATUSES }, allow_nil: true
end


