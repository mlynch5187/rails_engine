# Dione's Comments:
# Good job completing the rake task to import the csv data
# I like that you are converting the unit price before creating the resource
# It is also good to see that you are resetting the primary keys for each table

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
    if row["unit_price"]
      row["unit_price"] = (row["unit_price"].to_f / 100.0).round(2)
    end
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

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end
end
