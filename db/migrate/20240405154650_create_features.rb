class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.float :mag
      t.string :place, null: false
      t.date :time
      t.text :url, null: false
      t.boolean :tsunami
      t.string :mag_type, null: false
      t.string :title, null: false
      t.integer :longitude, null: false
      t.integer :latitude, null: false
      t.string :external_id

      t.timestamps
    end
  end
end
