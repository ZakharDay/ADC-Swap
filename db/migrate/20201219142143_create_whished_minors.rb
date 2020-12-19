class CreateWhishedMinors < ActiveRecord::Migration[6.1]
  def change
    create_table :whished_minors do |t|
      t.integer :profile_id
      t.integer :minor_id

      t.timestamps
    end
  end
end
