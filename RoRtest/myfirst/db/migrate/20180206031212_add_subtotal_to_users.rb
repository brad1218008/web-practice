class AddSubtotalToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :subtotal, :float
  end
end
