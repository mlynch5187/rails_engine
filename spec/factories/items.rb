FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyString" }
    unit_price { 1.7 }
    updated_at { "MyString" }
    created_at { "MyString" }
    merchant_id { nil }
  end

  factory :post do
    association :item, factory: :merchant
  end
end
