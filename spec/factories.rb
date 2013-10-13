require 'factory_girl'

FactoryGirl.define do

  factory :product do
    name '1 test_product'
    price 10
    type 'other'
    is_imported false

    factory :exempt_product do
      type 'book'
    end
    factory :imported_product do
      is_imported true
    end

    factory :imported_exempt_product do
      type 'book'
      is_imported true
    end

    initialize_with { new(name, price, type, is_imported) }
  end

  factory :item do
    quantity 1
    initialize_with { new(quantity, build(:product)) }
  end

  factory :order do
    after(:build) do |order|
      order << build(:item)
    end
    after(:create) do |order|
      order << build(:item)
    end
  end

  factory :receipt do
    item = build(:item)
    initialize_with { new([item]) }
  end


end
