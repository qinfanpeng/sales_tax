require_relative 'round05.rb'

class Item
  EXEMPT_GOODS = %w[book chocolate pill]

  def initialize(content)
    @content = content
    @quantity, @price, @name = nil, nil, nil
  end

  def taxs
    return (price * 0.05).round_nearest_05 if imported? and exempt?
    return (price * 0.15).round_nearest_05 if imported? and (not exempt?)
    return (price * 0.10).round_nearest_05 if not(imported?) and not(exempt?)
    return 0.00
  end

  def imported?
    @content.split.include? 'imported'
  end

  def exempt?
    EXEMPT_GOODS.each do |exempt_goods|
      return true if @content.include? exempt_goods
    end
    return false
  end

  def quantity
    @quantity ||= @content.split[0].to_i
  end

  def price
    @price ||= @content.split[-1].to_f
  end

  def name
    @name ||= @content.split(' at ')[0].strip
  end
end
