class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.text :device_token
      t.text :authenticity_token
      t.integer :filter_id

      t.timestamps
    end
  end
end
