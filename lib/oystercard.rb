class Oystercard

  attr_reader :balance
  def initialize
    @balance = 0
    @limit = 90
  end
  def top_up(amount)
    raise "Limit is #{@limit}" if @balance + amount > @limit
    @balance += amount
  end
end
