class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  validates :total_price, presence: true
  validates :status, presence: true
  validates :payment_method, presence: true
  validates :delivery_address, presence: true
  validates :client_phone, presence: true
end