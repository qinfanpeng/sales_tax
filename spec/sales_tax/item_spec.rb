require 'spec_helper'

describe Item do
  let(:item) { build(:item) }
  subject { item }

  it { should respond_to(:quantity) }

  it "should delegate #product_name to product's name" do
    item.product_name.should == item.product.name
  end

  it "should delegate #product_price to product's price" do
    item.product_price.should == item.product.price
  end

  it "#product_tax should equal product's tax x quantity" do
    item.product_tax.should == item.product.tax * item.quantity
  end

  it "#product_payment_amount should equal product's payment_amount x quantity" do
    item.product_payment_amount.should ==
      item.product.payment_amount * item.quantity
  end

end
