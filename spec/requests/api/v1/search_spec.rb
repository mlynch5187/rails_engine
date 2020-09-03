require 'rails_helper'

describe 'merchants search' do
  it 'can find merchants with names that include the params' do
    create(:merchant, name: 'Tire Shop')
    create(:merchant, name: 'Bikes Galore')
    create(:merchant, name: 'Tire Heaven')
    create(:merchant, name: 'Handlebars & Tire')

    find_params = '?name=tire'
    get "/api/v1/merchants/find_all#{find_params}"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end
end

describe 'items search' do
  before(:each) do
    @merchant_1 = create(:merchant, name: 'Tire Shop')
    @merchant_2 = create(:merchant, name: 'Bikes Galore')
    @item_1_params = { name: 'Spoke', description: 'Get Going', unit_price: 7.0, created_at: '2010-12-19 14:53:59 UTC' }
    @item_2_params = { name: 'Brakes', description: 'When You Need To Stop', unit_price: 1.2, created_at: '2019-05-18 14:54:02 UTC' }
    @item_3_params = { name: 'Bike Seat', description: 'Premium Seat For Your Bike', unit_price: 9.2 }
    @item_4_params = { name: 'Bell', description: 'Announce Your Presence', unit_price: 1.2 }
    @merchant_1.items.create(@item_1_params)
    @merchant_1.items.create(@item_2_params)
    @merchant_2.items.create(@item_3_params)
    @merchant_2.items.create(@item_4_params)
  end

  it 'can find one item with passed params name' do
    get '/api/v1/items/find?name=spok'
    spoke = JSON.parse(response.body)
    expect(response).to be_successful
    expect(spoke.first).to have_value('Get Going')
    expect(spoke.first).to have_value('Spoke')
  end

  it 'can find one item by description' do
    get '/api/v1/items/find?description=presence'
    bell_descrip = JSON.parse(response.body)
    expect(response).to be_successful

    expect(bell_descrip.first).to have_value('Announce Your Presence')
  end

  it 'can find all items by descriptions' do
    get '/api/v1/items/find_all?description=seat'
    seat_descrip = JSON.parse(response.body)
    expect(seat_descrip.count).to eq(1)
  end

  it 'can find all items bys name and description' do
    get '/api/v1/items/find_all?name=bell&description=going'
    bell_going = JSON.parse(response.body)
    expect(bell_going.count).to eq(2)
  end

  it 'can find all items by name' do
    get '/api/v1/items/find_all?name=spoke'
    spoke = JSON.parse(response.body)
    expect(spoke.count).to eq(1)
  end

  xit 'can find one item by created_at' do
    get '/api/v1/items/find?created_at=2019-05-18'
    date_created = JSON.parse(response.body)
    expect(response).to be_successful
    expect(date_created.first).to have_value('Brakes')
  end



  it 'can find all items by prices' do
    get '/api/v1/items/find_all?unit_price=1.2'
    unit_price_5 = JSON.parse(response.body)
    expect(unit_price_5.count).to eq(2)
  end

end
