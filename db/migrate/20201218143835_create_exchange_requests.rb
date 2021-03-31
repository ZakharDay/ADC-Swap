class CreateExchangeRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_requests do |t|
      t.integer :requester_id
      t.integer :requester_minor_id
      t.integer :responder_id
      t.integer :responder_minor_id
      t.integer :exchange_minor_id
      t.boolean :approved_by_responder
      t.string :status, default: "start"
      t.integer :responder_status
      t.string :time_of_change_responder_status, default: ""
      t.integer :requester_status
      t.string :time_of_change_requester_status, default: ""

      t.timestamps
    end
  end
end
