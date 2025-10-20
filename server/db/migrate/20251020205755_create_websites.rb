class CreateWebsites < ActiveRecord::Migration[8.0]
  def change
    create_table :websites do |t|
      t.references :workspace, null: false, foreign_key: true
      t.string :url
      t.string :scan_schedule
      t.string :status

      t.timestamps
    end
  end
end
