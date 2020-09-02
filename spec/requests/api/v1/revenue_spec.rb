require 'rails_helper'

describe "revenue filter" do
  before(:all) do
    #merchants
    @merchant_1 = create(:merchant, name: "Bakery")
    @merchant_2 = create(:merchant, name: "London Bakers")
    @merchant_3 = create(:merchant, name: "Lousiville")

    #customers
    @customer = Customer.create({ first_name: "Joey",
                                  last_name: "Ondricka" })

    #items
    @item_1_params = { name: "Candy",
                      description: "Hot and spicy",
                      unit_price: 10.0,
                      created_at: "2020-01-13 14:53:59 UTC" }
    @item_2_params = { name: "Can-o-Beans",
                      description: "Comes in a jar",
                      unit_price: 5.0 }
    @item_1 = @merchant_1.items.create(@item_1_params)
    @item_2 = @merchant_1.items.create(@item_2_params)

    #invoices
    @invoice_1_params = { customer_id: @customer.id,
                          merchant_id: @merchant_1.id,
                          status: "shipped" }
    @invoice_2_params = { customer_id: @customer.id,
                          merchant_id: @merchant_1.id,
                          status: "shipped"}
    @invoice_1 = Invoice.create(@invoice_1_params)
    @invoice_2 = Invoice.create(@invoice_2_params)

    @invoice_items_1_params = { item_id: @item_1.id,
                                invoice_id: @invoice_1.id,
                                quantity: 5,
                                unit_price: 10.0 }
    @invoice_items_2_params = { item_id: @item_2.id,
                                invoice_id: @invoice_2.id,
                                quantity: 13,
                                unit_price: 5.0 }
    InvoiceItem.create(@invoice_items_1_params)
    InvoiceItem.create(@invoice_items_2_params)

  end
  it "should get total revenue for a merchant" do
    get "/api/v1/merchants/#{@merchant_1.id}/revenue"

    expect(response).to be_successful
  end
end
