class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.integer :education_year
      t.integer :program_id
      t.integer :minor_id
      t.integer :user_id
      t.boolean :published

      t.timestamps
    end
  end
end
