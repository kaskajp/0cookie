class CookieFinding < ApplicationRecord
  belongs_to :scan

  validates :name, presence: true
end


