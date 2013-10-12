
class SalesTaxCalculator
  attr_reader :items

  def initialize
    @items = []
  end

  def items=(item_contents)
    item_contents.each do |item_content|
      @items << Item.new(item_content)
    end
  end

  def run
    total_taxs, total_paid = 0, 0
    result = []
    @items.each do |item|
      taxs = item.taxs
      paid = (item.price + taxs) * item.quantity
      result << "#{item.name}: #{'%.2f' % paid}"
      total_taxs += taxs * item.quantity
      total_paid += paid
    end
    result << "Sales Taxes: #{'%.2f' % total_taxs}"
    result << "Total: #{'%.2f' % total_paid}"
  end

end
