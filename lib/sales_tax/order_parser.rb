require_relative '../../config/product_type'

class OrderParser
  def parse(contents)
    order = Order.new
    contents.each do |content|
      product = Product.new(
                        product_name_in(content),
                        price_in(content),
                        type_in(content),
                        imported_in(content)
                        )
      order << Item.new(quantity_in(content), product)
    end
    return order
  end

  private
  def quantity_in(content)
    content.split[0].to_i
  end

  def price_in(content)
    content.split[-1].to_f
  end

  def product_name_in(content)
    content.split(' at ')[0]
  end

  def type_in(content)
    TYPES.each do |name, type|
      return TYPES[name] if content.include?(name.to_s)
    end
    return 'other'
  end

  def imported_in(content)
    content.split.include? 'imported'
  end
end
