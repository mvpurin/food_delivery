class AddDeliveryPersonToOrder < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :delivery_person, foreign_key: true
  end
end
