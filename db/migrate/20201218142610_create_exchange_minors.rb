class CreateExchangeMinors < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_minors do |t|
      t.integer :profile_id
      t.integer :minor_id
      t.boolean :published

      t.timestamps
    end
  end
end
