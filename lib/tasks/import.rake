require 'csv'

task import: :environment do
  puts "destroying invoice items.."
    InvoiceItem.destroy_all
  puts "destroying transactions.."
    Transaction.destroy_all
  puts "destroying invoices.."
    Invoice.destroy_all
  puts "destroying items.."
    Item.destroy_all
  puts "destroying customers.."
    Customer.destroy_all
  puts "destroying merchants.."
    Merchant.destroy_all

  puts "building customers.."
    customers = File.join Rails.root, "data/customers.csv"
  CSV.foreach(customers, headers: true) do |row|
    Customer.create(row.to_h)
  end

  puts "building merchants.."
    merchants = File.join Rails.root, "data/merchants.csv"
  CSV.foreach(merchants, headers: true) do |row|
    Merchant.create(row.to_h)
  end

  puts "building items.."
    items = File.join Rails.root, "data/items.csv"
  CSV.foreach(items, headers: true) do |row|
    Item.create(row.to_h)
  end

  puts "building invoices.."
    invoices = File.join Rails.root, "data/invoices.csv"
  CSV.foreach(invoices, headers: true) do |row|
    Invoice.create(row.to_h)
  end

  puts "building transactions.."
    transactions = File.join Rails.root, "data/transactions.csv"
  CSV.foreach(transactions, headers: true) do |row|
    Transaction.create(row.to_h)
  end

  puts "building invoice items.."
    invoice_items = File.join Rails.root, "data/invoice_items.csv"
  CSV.foreach(invoice_items, headers: true) do |row|
    InvoiceItem.create(row.to_h)
  end
end