class AddAuthFieldsToGuest < ActiveRecord::Migration[6.1]
  def change
    add_column :guests, :email, :string
    add_column :guests, :code, :string
  end
end
