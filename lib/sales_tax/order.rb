
class Order
  attr_reader :items

  def initialize
    @items = []
  end

  def <<(item)
    @items << item
  end

  def remove(item)
    @items.delete(item)
  end

  def check_out
    receipt = Receipt.new(@items)
    receipt.total_taxs = self.total_taxs
    receipt.total_payment_amount = self.total_payment_amount
    @items = []
    return receipt
  end

  def total_taxs
    @items.inject(0.00){ |total_taxs, item| total_taxs + item.product_tax }
  end

  def total_payment_amount
    @items.inject(0) do |total_payment_amount, item|
      total_payment_amount + item.product_payment_amount
    end
  end

  def show
    result = []
    @items.each do |item|
      result << "#{item.quantity} #{item.product_name} at #{'%.2f' % item.product_price}"
    end
    return result
  end
end
