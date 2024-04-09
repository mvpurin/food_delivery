require 'rails_helper'

RSpec.describe Services::PayOrder do
  let(:order) { instance_double(Order) }
  let(:service) { instance_double(Services::AddCourierToOrder) }

  it 'calls #pay method to order' do
    expect(order).to receive(:pay)
    Services::PayOrder.new.call(order)
  end

  it 'calls Services::AddCourierToOrder' do
    expect(Services::AddCourierToOrder).to receive(:new).and_return(service)
    expect(order).to receive(:pay)
    expect(service).to receive(:call).with(order)
    Services::PayOrder.new.call(order)
  end
end