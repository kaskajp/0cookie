class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :workspace, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.string :status
      t.datetime :period_start
      t.datetime :period_end

      t.timestamps
    end
  end
end


