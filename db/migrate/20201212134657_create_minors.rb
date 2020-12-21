class CreateMinors < ActiveRecord::Migration[6.1]
  def change
    create_table :minors do |t|
      t.integer :start_year
      t.integer :organisation_id
      t.integer :program_id
      t.integer :city_id
      t.string :name
      t.text :description
      t.integer :credits
      t.string :address
      t.string :responsible
      t.text :url
      t.text :details_url
      t.boolean :notice, default: false

      t.timestamps
    end
  end
end
