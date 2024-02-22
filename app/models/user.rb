class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true
  validates :phone_number, presence: true, uniqueness: true

  def current_order
    order = Order.where(user_id: self.id, status: 'in progress').first

    order.present? ? order : nil
  end
end
