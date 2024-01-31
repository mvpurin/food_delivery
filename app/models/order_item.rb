class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :price, presence: true
  validates :amount, presence: true
end