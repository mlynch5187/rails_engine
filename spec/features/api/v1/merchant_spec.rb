require 'rails_helper'

describe 'Merchants' do
  it 'can retrieve merchant info' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants['data'].count).to eq(5)

    merchants['data'].each do |merchant|
      expect(merchant).to have_key('attributes')
      expect(merchant).to have_key('type')
      expect(merchant).to have_key('id')
      expect(merchant).to have_value({ 'name' => 'MyString' })
    end
  end

  it 'can return merchant items' do
    merchant1 = create(:merchant)
    create_list(:item, 5, merchant_id: "#{merchant1.id}")

    get "/api/v1/merchants/#{merchant1.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data'].count).to eq(5)

    items['data'].each do |item|
      expect(item).to have_key('id')
      expect(item).to have_key('type')
      expect(item).to have_value('items')
    end

    it 'item can be updated' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      old_name = item.name
      updated_params = { name: "New Name",
                          description: "New Description",
                          unit_price: 5.0 }

      put "/api/v1/items/#{item.id}", params: { item: updated_params }
      expect(response).to be_successful

      updated_item = Item.find(item.id)

      expect(updated_item.name).to eq("New Name")
      expect(updated_item.name).to_not eq("#{old_name}")
      expect(updated_item.description).to eq("New Description")
      expect(updated_item.unit_price).to eq(5.0)
    end

    it 'item can be deleted' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)

      expect(merchant.items.count).to eq(2)

      delete "/api/v1/items/#{item_1.id}"

      expect(response).to be_successful
      expect(merchant.items.count).to eq(1)
    end

    it 'a single item can be retrieved' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      get "/api/v1/items/#{item.id}"
      item_response = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item_response.count).to eq(1)
      expect(item_response['data']['attributes']).to have_key('description')
      expect(item_response['data']['attributes']).to have_key('unit-price')
      expect(item_response['data']['attributes']).to have_key('name')
      expect(item_response['data']['attributes']).to have_value(item.name)
    end
  end
end
