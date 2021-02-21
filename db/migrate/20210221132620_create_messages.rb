class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :profile_id
      t.integer :exchange_request_id
      t.text :content

      t.timestamps
    end
  end
end
