class ConsentRecord < ApplicationRecord
  belongs_to :website

  validates :session_id_hash, presence: true
  validates :policy_version, presence: true
end


