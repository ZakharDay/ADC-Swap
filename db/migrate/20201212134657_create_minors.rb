class CreateMinors < ActiveRecord::Migration[6.1]
  def change
    create_table :minors do |t|
      t.integer :start_year
      t.integer :program_id
      t.string :name
      t.text :description
      t.text :url

      t.timestamps
    end
  end
end
