require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_many(:orders).through(:order_items) }
  it { should belong_to(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:additional_info) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_numericality_of(:price).is_greater_than(0) }
  it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
end
