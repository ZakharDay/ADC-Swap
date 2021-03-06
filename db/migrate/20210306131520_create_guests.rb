class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.text :token
      t.integer :filter_id

      t.timestamps
    end
  end
end
