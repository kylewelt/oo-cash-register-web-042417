require 'pry'

class CashRegister

  attr_accessor :total, :items, :last_item
  attr_reader :discount

  def initialize(discount = 0)
    @total = 0
    @discount = discount
    @items = []
  end

  def add_item(title, price, quantity = 1)
    self.total += (price * quantity)

    quantity.times do
      self.items << title
    end

    @last_item  = {
      :title => title,
      :price => price,
      :quantity => quantity
    }
  end

  def apply_discount
    self.total = self.total * (1 - self.discount / 100.0)

    if self.total == 0
      "There is no discount to apply."
    else
      if self.total % 1 == 0
        self.total = self.total.to_i
      else
        self.total = sprintf( "%0.02f", self.total)
      end
      "After the discount, the total comes to $#{self.total}."
    end
  end

  def void_last_transaction
    self.last_item[:quantity].times do
      self.items.pop
    end
    
    self.total = self.total - last_item[:quantity] * last_item[:price]
  end

end
