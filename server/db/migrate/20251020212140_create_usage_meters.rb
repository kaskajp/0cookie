class CreateUsageMeters < ActiveRecord::Migration[8.0]
  def change
    create_table :usage_meters do |t|
      t.references :workspace, null: false, foreign_key: true
      t.string :metric, null: false
      t.date :period_start, null: false
      t.date :period_end, null: false
      t.integer :used, default: 0, null: false

      t.timestamps
    end
    add_index :usage_meters, [:workspace_id, :metric, :period_start, :period_end], name: "index_usage_unique_period", unique: true
  end
end


