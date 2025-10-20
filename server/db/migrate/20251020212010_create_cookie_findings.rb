class CreateCookieFindings < ActiveRecord::Migration[8.0]
  def change
    create_table :cookie_findings do |t|
      t.references :scan, null: false, foreign_key: true
      t.string :name
      t.string :domain
      t.string :path
      t.string :expiry
      t.string :category_suggested
      t.integer :confidence

      t.timestamps
    end
  end
end


