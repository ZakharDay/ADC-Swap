class CreateOrganisations < ActiveRecord::Migration[6.1]
  def change
    create_table :organisations do |t|
      t.integer :parent_id
      t.string :name
      t.text :url

      t.timestamps
    end
  end
end
