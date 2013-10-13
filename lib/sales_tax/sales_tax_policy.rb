require 'singleton'

class SalesTaxPolicy
  include Singleton

  attr_accessor :basic_sales_tax_rate, :imported_sales_tax_rake, :exempt_product_types

  def initialize
    @basic_sales_tax_rate = 0.1
    @imported_sales_tax_rate = 0.05
    @exempt_product_types = %w[book food medical]
  end

  def self.add_exempt_product_type(exempt_product_type)
    @exempt_product_types << exempt_product_type
  end

  def self.remove_exempt_product_type(exempt_product_type)
    @exempt_product_types.delete exempt_product_type
  end

  def tax_of(product)
    price, is_imported, is_exempt = product.price, product.is_imported, product.exempt?
    return (price * 0.05).round_nearest_05 if is_imported and is_exempt
    return (price * 0.15).round_nearest_05 if is_imported and (not is_exempt)
    return (price * 0.10).round_nearest_05 if not(is_imported) and not(is_exempt)
    return 0.00
  end
end
