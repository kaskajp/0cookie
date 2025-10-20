class Website < ApplicationRecord
  belongs_to :workspace

  validates :url, presence: true
  validates :status, inclusion: { in: %w[active paused archived], allow_nil: true }
end
