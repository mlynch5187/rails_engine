require 'rails_helper'

describe 'Items' do
  xit 'can retrieve item info' do
    create_list(:item, 5)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(5)
    items.each do |item|
      expect(item).to have_key('name')
      expect(item).to have_key('description')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('updated_at')
      expect(item).to have_key('created_at')
      expect(item).to have_key('merchant_id')
    end
  end
end
