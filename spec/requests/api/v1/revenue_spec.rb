require 'rails_helper'

describe "revenue filter" do
  before(:all) do
    #merchants
    @merchant_1 = create(:merchant, name: "Tire Shop")
    @merchant_2 = create(:merchant, name: "Bikes Galore")
    @merchant_3 = create(:merchant, name: "Tire Heaven")

    #customers
    @customer = Customer.create({ first_name: "Mike",
                                  last_name: "Smith" })

    #items
    @item_1_params = { name: "Spoke",
                      description: "Get Going",
                      unit_price: 7.0,
                      created_at: "2010-12-19 14:53:59 UTC" }
    @item_2_params = { name: "Brakes",
                      description: "When You Need To Stop",
                      unit_price: 1.2 }
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
                                unit_price: 7.0 }
    @invoice_items_2_params = { item_id: @item_2.id,
                                invoice_id: @invoice_2.id,
                                quantity: 13,
                                unit_price: 1.2 }
    InvoiceItem.create(@invoice_items_1_params)
    InvoiceItem.create(@invoice_items_2_params)

  end
  it "retrieves total revenue for a merchant" do
    get "/api/v1/merchants/#{@merchant_1.id}/revenue"

    expect(response).to be_successful
  end
end
