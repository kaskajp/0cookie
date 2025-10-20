class Scan < ApplicationRecord
  belongs_to :website

  has_many :cookie_findings, dependent: :destroy

  validates :website, presence: true
end


