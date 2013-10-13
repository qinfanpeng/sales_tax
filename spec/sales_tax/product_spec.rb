require 'spec_helper'

describe Product do
  let(:product) { build(:product) }
  subject { product }

  it { should respond_to(:name) }
  it { should respond_to(:price) }
  it { should respond_to(:type) }
  it { should respond_to(:is_imported) }

  it 'should delegate #tax to SalesTaxPolicy.instance' do
    product.tax.should == 1.0
  end

  it '#paymeng_amount should equal price add tax' do
    product.payment_amount.should ==
      (product.price + product.tax)
  end
end
