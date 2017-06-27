class CreateGpslocations < ActiveRecord::Migration[5.0]
  def change
    create_table :gpslocations do |t|
      t.string :name
      t.string :address
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6

      t.timestamps
    end
  end
end
