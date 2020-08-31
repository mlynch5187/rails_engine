require 'rails_helper'

describe 'Items API' do
  it 'can retrieve item info' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(5)

    items['data'].each do |item|
      expect(item['attributes']).to have_key('name')
      expect(item['attributes']).to have_key('description')
      expect(item['attributes']).to have_key('unit_price')
      expect(item['attributes']).to have_key('merchant_id')
    end
  end

  it "can send 1 item by id" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}"
    item_response = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_response.count).to eq(1)
    expect(item_response["data"]["attributes"]).to have_key("description")
    expect(item_response["data"]["attributes"]).to have_key("unit_price")
    expect(item_response["data"]["attributes"]).to have_key("name")
    expect(item_response["data"]["attributes"]).to have_value(item.name)
  end

  it 'items can be created' do
    merchant = create(:merchant)

    params = { name: 'Teddy Bear',
               description: 'Loveable',
               unit_price: 2.1,
               merchant_id: merchant.id }

    post '/api/v1/items', params: { item: params }

    expect(response).to be_successful

    created_item = Item.last

    expect(created_item.name).to eq('Teddy Bear')
    expect(created_item.unit_price).to eq(2.1)
    expect(created_item.description).to eq('Loveable')
  end

  it 'items can be updated' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    old_name = item.name
    new_item_params = { "name": "New Name",
                        "description": "New Description",
                        "unit_price": 2.5 }

    put "/api/v1/items/#{item.id}", params: { item: new_item_params }

    expect(response).to be_successful

    updated_item = Item.find(item.id)

    expect(updated_item.name).to_not eq(old_name)
    expect(updated_item.name).to eq("New Name")
    expect(updated_item.unit_price).to eq(2.5)
    expect(updated_item.description).to eq("New Description")
  end

  it 'items can be deleted' do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)

    expect(merchant.items.count).to eq(3)

    delete "/api/v1/items/#{item_1.id}"

    expect(response).to be_successful
    expect(merchant.items.count).to eq(2)
  end
end
