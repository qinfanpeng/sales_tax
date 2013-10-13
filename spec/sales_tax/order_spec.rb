require 'spec_helper'

describe Order do
  let(:order) { build(:order) }
  let(:item) { build(:item) }

  it "#<< should add one item to it" do
    order << item
    order.items.size.should == 2
  end

  it "#remove should add one item to it" do
    order << item
    order.remove(item)
    order.items.size.should == 1
  end

  it "#check_out should clear it's items \
and return a receipt" do
    receipt = order.check_out

    receipt.class.should == Receipt
    receipt.total_taxs.should == 1.0
    receipt.total_payment_amount.should == 11.0

    order.items.size.should == 0
  end

  it "#total_tax should eq sum of all the product tax in items" do
    order.total_taxs.should == item.product_tax
  end

  it "#total_payment_amount should eq sum of all product payment amount" do
    order.total_payment_amount == item.product_payment_amount
  end

  it "#show return an array which conatins the order's content" do
    order.show.should == ["1 test_product at 10.00"]
  end
end
