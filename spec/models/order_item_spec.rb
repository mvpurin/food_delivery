require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to(:item) }
  it { should belong_to(:order) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:amount) }
end
