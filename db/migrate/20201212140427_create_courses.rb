class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :year
      t.integer :organisation_id
      t.integer :minor_id
      t.integer :modules, array: true
      t.text :url

      t.timestamps
    end
  end
end
