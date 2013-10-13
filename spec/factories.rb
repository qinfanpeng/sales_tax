require 'factory_girl'

FactoryGirl.define do

  factory :product do
    name 'test_product'
    price 10
    type 'other'
    is_imported false

    factory :exempt_product do
      type 'book'
    end
    factory :imported_product do
      is_imported true
    end

    initialize_with { new(name, price, type, is_imported) }
  end

  factory :item do
    quantity 1
    initialize_with { new(quantity, build(:product)) }
  end

  factory :order do
  end


end
