class DeliveryPerson < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :order

  validates :first_name, :last_name, presence: true
  validates :phone_number, presence: true, uniqueness: true

  def complete_order
    ActiveRecord::Base.transaction do
      order.update!(status: 'completed')
      update!(order: nil, status: 'free')
    end
  end
end
