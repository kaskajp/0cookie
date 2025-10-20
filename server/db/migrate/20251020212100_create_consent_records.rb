class CreateConsentRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :consent_records do |t|
      t.references :website, null: false, foreign_key: true
      t.string :session_id_hash, null: false
      t.text :purposes
      t.string :region
      t.string :policy_version, null: false

      t.timestamps
    end
    add_index :consent_records, [:website_id, :session_id_hash]
  end
end


