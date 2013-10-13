require 'spec_helper'

describe Order do
  let(:order) { build(:order) }
  let(:item) { build(:item) }

  it "#<< should add one item to it" do
    order << item
    order.items.size.should == 1
  end

  it "#remove should add one item to it" do
    order.remove(item)
    order.items.size.should == 0
  end

  it "#check_out should clear it's items \
and return a receipt" do
    order << item
    order.check_out.class.should == Receipt
    order.items.size.should == 0
  end


end
