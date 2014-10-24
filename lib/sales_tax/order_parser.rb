require_relative '../../config/product_type'

class OrderParser
  def parse(order_content)
    order = Order.new
    order_content.each do |item_content|
      product = Product.new(
                        product_name_in(item_content),
                        price_in(item_content),
                        type_in(item_content),
                        imported_in(item_content)
                        )
      order << Item.new(quantity_in(item_content), product)
    end
    return order
  end

  private
  def quantity_in(item_content)
    item_content.split[0].to_i
  end

  def price_in(item_content)
    item_content.split[-1].to_f
  end

  def product_name_in(item_content)
    item_content.split(' at ')[0]
  end

  def type_in(item_content)
    TYPES.each do |name, type|
      return TYPES[name] if item_content.include?(name.to_s)
    end
    return 'other'
  end

  def imported_in(item_content)
    item_content.split.include? 'imported'
  end
end
