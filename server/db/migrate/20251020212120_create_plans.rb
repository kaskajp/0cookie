class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.json :entitlements

      t.timestamps
    end
    add_index :plans, :name, unique: true
  end
end


