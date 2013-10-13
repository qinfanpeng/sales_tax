
class Product
  attr_reader :name, :price, :type, :is_imported

  def initialize(name, price, type, is_imported)
    @name, @price, @type = name, price, type
    @is_imported = is_imported
    @sales_tax_policy = SalesTaxPolicy.instance
  end

  def tax
    @sales_tax_policy.tax_of(self)
  end

  def exempt?
    @sales_tax_policy.exempt_product_types.include? @type
  end

  def payment_amount
    @price + self.tax
  end
end
