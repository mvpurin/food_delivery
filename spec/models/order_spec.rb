require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many(:items).through(:order_items) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:total_price) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:payment_method) }
  it { should validate_presence_of(:delivery_address) }
  it { should validate_presence_of(:client_phone) }
end
