class Oystercard

  attr_reader :balance
  def initialize
    @balance = 0
    @limit = 90
    @in_journey = false
  end
  def top_up(amount)
    raise "Limit is #{@limit}" if @balance + amount > @limit
    @balance += amount
  end
  def deduct(amount)
    @balance -= amount
  end
  def touch_in
    @in_journey = true
  end
  def touch_out
    @in_journey = false
  end
  def in_journey?
    @in_journey
  end
end
