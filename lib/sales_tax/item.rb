class Item
  attr_reader :quantity, :product

  def initialize(quantity, product)
    @quantity,@product = quantity, product
  end

  def product_tax
    @product.tax * @quantity
  end

  def product_payment_amount
    @product.payment_amount * @quantity
  end

  #####################
  # def product_name  #
  #   @product.name   #
  # end               #
  #                   #
  # def product_price #
  #   @product.price  #
  # end               #
  #####################

  [:product_name, :product_price].each do |method_name|
    product_attr = method_name.to_s.split('_')[-1]
    define_method(method_name) { @product.send(product_attr)}
  end
end
