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
end
