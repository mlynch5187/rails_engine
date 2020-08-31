require 'rails_helper'

describe 'Items API' do
  xit 'can retrieve item info' do
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

  xit 'items can be created' do
   merchant = create(:merchant)
   create(:item, merchant: merchant)

   params = { 'name' => 'Teddy Bear',
                   'description' => 'Loveable',
                   'unit_price' => 3.4 }

   post '/api/v1/items', params: { item: params,
                                   merchant: merchant }
   expect(response).to be_successful
   bear = Item.last
   expect(bear.name).to eq('Teddy Bear')
   expect(bear.description).to eq('Loveable')
   expect(bear.unit_price).to eq(3.4)
  end
end
