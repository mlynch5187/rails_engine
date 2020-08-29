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

end
