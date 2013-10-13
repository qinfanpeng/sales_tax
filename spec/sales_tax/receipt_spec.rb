require 'spec_helper'

describe Receipt do
  let(:order) { build(:order) }
  let(:receipt) { order.check_out }
  subject { receipt }

  it { should respond_to(:total_taxs) }
  it { should respond_to(:total_payment_amount) }
  it { should respond_to(:items) }

  it "#show return an array which contains receipt's content" do
    receipt.show.should == [
      "1 test_product: 11.00",
      'Sales Taxes: 1.00',
      'Total: 11.00']
  end
end
