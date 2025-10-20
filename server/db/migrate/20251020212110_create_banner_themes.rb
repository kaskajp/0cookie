class CreateBannerThemes < ActiveRecord::Migration[8.0]
  def change
    create_table :banner_themes do |t|
      t.references :workspace, null: false, foreign_key: true
      t.json :variables

      t.timestamps
    end
  end
end


