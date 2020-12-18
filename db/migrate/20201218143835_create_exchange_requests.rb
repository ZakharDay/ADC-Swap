class CreateExchangeRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_requests do |t|
      t.integer :requester_id
      t.integer :requester_minor_id
      t.integer :responder_id
      t.integer :responder_minor_id
      t.integer :exchange_minor_id
      t.boolean :approved_by_responder

      t.timestamps
    end
  end
end
