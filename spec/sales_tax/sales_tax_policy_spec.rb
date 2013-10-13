require 'spec_helper'

describe SalesTaxPolicy do
  let(:sales_tax_policy) { SalesTaxPolicy.instance }
  let(:product) { build(:product) }
  let(:exempt_product) { build(:exempt_product) }
  let(:imported_product) { build(:imported_product) }
  let(:imported_exempt_product) { build(:imported_exempt_product) }
  subject { sales_tax_policy }

  it { should respond_to(:basic_sales_tax_rate) }
  it { should respond_to(:imported_sales_tax_rate) }
  it { should respond_to(:exempt_product_types) }

  it { should respond_to(:basic_sales_tax_rate=) }
  it { should respond_to(:imported_sales_tax_rate=) }
  it { should respond_to(:exempt_product_types=) }

  its(:basic_sales_tax_rate) { should == 0.1 }
  its(:imported_sales_tax_rate) { should == 0.05 }
  its(:exempt_product_types) { should == %w[book food medical] }

  it "#add_exempt_product_type should add a new exempt prodcut type" do
    sales_tax_policy.add_exempt_product_type('new_exempt_type')
    sales_tax_policy.exempt_product_types
      .should == %w[book food medical new_exempt_type]
  end

  it "#remove_exempt_product_type should remove an exempt prodcut type" do
    sales_tax_policy.remove_exempt_product_type('new_exempt_type')
    sales_tax_policy.exempt_product_types
      .should == %w[book food medical]
  end

  it "#tax_of(product) should calculate the product's sales tax" do
    sales_tax_policy.tax_of(product).should == 1.0
    sales_tax_policy.tax_of(exempt_product).should == 0.0
    sales_tax_policy.tax_of(imported_product).should == 1.5
    sales_tax_policy.tax_of(imported_exempt_product).should == 0.5
  end

end
