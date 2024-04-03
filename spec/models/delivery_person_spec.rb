require 'rails_helper'

RSpec.describe DeliveryPerson, type: :model do
  it { should have_one(:order) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_uniqueness_of(:phone_number) }
end
