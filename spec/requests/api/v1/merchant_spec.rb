require 'rails_helper'

describe 'Merchants API' do
  it 'can retrieve merchant info' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants['data'].count).to eq(3)

    merchants['data'].each do |merchant|
      expect(merchant).to have_key('attributes')
      expect(merchant).to have_key('type')
      expect(merchant).to have_key('id')
      expect(merchant).to have_value({ 'name' => 'MyString' })
    end
  end

  it 'can return merchant items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: "#{merchant.id}")

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key('id')
      expect(item).to have_key('name')
      expect(item).to have_value('kitten mittens')
      expect(item).to have_value('slippers for your cat')
      expect(item).to have_key('unit_price')
      expect(item).to have_value(1.7)
      expect(item).to have_key('merchant_id')
    end
  end

    it 'item can be updated' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      old_name = item.name
      updated_params = { name: "puppy paws",
                          description: "paws for your pooch",
                          unit_price: 1.7 }

      put "/api/v1/items/#{item.id}", params: { item: updated_params }
      expect(response).to be_successful

      updated_item = Item.find(item.id)

      expect(updated_item.name).to eq("puppy paws")
      expect(updated_item.name).to_not eq("#{old_name}")
      expect(updated_item.description).to eq("paws for your pooch")
      expect(updated_item.unit_price).to eq(1.7)
    end

    it 'merchant can be updated' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      old_name = merchant.name
      updated_params = { name: "Playdough Factory" }

      put "/api/v1/merchants/#{merchant.id}", params: { merchant: updated_params }
      expect(response).to be_successful

      updated_merchant = Merchant.find(merchant.id)

      expect(updated_merchant.name).to eq("Playdough Factory")
    end

    it 'merchant item can be deleted' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)

      expect(merchant.items.count).to eq(2)

      delete "/api/v1/items/#{item_1.id}"

      expect(response).to be_successful
      expect(merchant.items.count).to eq(1)
    end

    it 'a single merchant item can be retrieved' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      get "/api/v1/items/#{item.id}"
      item_response = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item_response.count).to eq(1)
      expect(item_response['data']['attributes']).to have_key('description')
      expect(item_response['data']['attributes']).to have_key('unit_price')
      expect(item_response['data']['attributes']).to have_key('name')
      expect(item_response['data']['attributes']).to have_value(item.name)
    end

    it "can destroy a single merchant" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      create(:item, merchant: merchant)
      create_list(:merchant, 2)

      expect(Merchant.all.count).to eq(3)

      delete "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_successful
      expect(Merchant.all.count).to eq(2)
  end
end
