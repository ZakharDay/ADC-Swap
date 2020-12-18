class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.string :name
      t.integer :organisation_id
      t.text :url

      t.timestamps
    end
  end
end
