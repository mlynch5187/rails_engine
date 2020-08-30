require 'rails_helper'

describe 'Merchants' do
  xit 'can retrieve merchant info' do
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

  xit 'can return merchant items' do
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
  end
end
