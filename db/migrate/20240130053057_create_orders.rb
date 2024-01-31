class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.float :total_price
      t.string :status, default: 'in progress'
      t.string :payment_method
      t.string :delivery_address
      t.string :client_phone
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
