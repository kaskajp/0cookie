class CreateScans < ActiveRecord::Migration[8.0]
  def change
    create_table :scans do |t|
      t.references :website, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at
      t.text :results_summary

      t.timestamps
    end
  end
end


