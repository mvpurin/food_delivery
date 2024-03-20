class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  validates :total_price, presence: true
  validates :status, presence: true
  validates :payment_method, presence: true
  validates :delivery_address, presence: true
  validates :client_phone, presence: true

  def summ_price
    self.order_items.sum { |order_item| order_item.price * order_item.amount }
  end

  def decrease_items_amount
    self.order_items.each do |order_item|
      item = Item.find(order_item.item_id)
      item.update(amount: item.amount - order_item.amount)
    end
  end
end