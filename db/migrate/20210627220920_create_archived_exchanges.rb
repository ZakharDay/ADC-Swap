class CreateArchivedExchanges < ActiveRecord::Migration[6.1]
  def change
    create_table :archived_exchanges do |t|
      t.integer :profile_id
      t.integer :minor_id

      t.timestamps
    end
  end
end
