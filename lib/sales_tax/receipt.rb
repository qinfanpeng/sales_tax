class Receipt
  attr_accessor :total_taxs, :total_payment_amount
  attr_reader :items

  def initialize(items)
    @items = items
    @total_taxs = 0.0
    @total_payment_amount = 0.0
  end

  def show
    result = []
    @items.each do |item|
      result << "#{item.product_name}: #{'%.2f' % item.product_payment_amount}"
    end

    result << "Sales Taxes: #{'%.2f' % total_taxs}"
    result << "Total: #{'%.2f' % total_payment_amount}"
    return result
  end
end
