class UsageMeter < ApplicationRecord
  belongs_to :workspace

  validates :metric, presence: true
  validates :period_start, presence: true
  validates :period_end, presence: true
end


