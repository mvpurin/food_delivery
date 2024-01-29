class Item < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :amount, presence: true
  validates :additional_info, presence: true
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :amount, greater_than_or_equal_to: 0
end
