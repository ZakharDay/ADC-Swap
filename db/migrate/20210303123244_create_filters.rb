class CreateFilters < ActiveRecord::Migration[6.1]
  def change
    create_table :filters do |t|
      t.integer :profile_id
      t.integer :city_id
      t.integer :year

      t.timestamps
    end
  end
end
