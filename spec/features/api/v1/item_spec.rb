require 'rails_helper'

describe 'Items' do
  it 'can retrieve item info' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(5)
    items['data'].each do |item|
      expect(item).to have_key('name')
      expect(item).to have_key('description')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('merchant_id')
    end
  end

  it 'items can be created' do
   merchant = create(:merchant)
   create(:item, merchant: merchant)

   item_params = { "name" => "Test Item",
                   "description" => "Test Des",
                   "unit_price" => 2.1 }

   post "/api/v1/items", params: { item: item_params,
                                   merchant: merchant }
   expect(response).to be_successful
   item = Item.last
   expect(item.name).to eq("Test Item")
   expect(item.description).to eq("Test Des")
   expect(item.unit_price).to eq(2.1)
  end
end
