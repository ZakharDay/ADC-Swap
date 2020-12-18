class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :education_year
      t.integer :program_id
      t.integer :minor_id
      t.integer :user_id
      t.boolean :published

      t.timestamps
    end
  end
end
