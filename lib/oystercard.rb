class Oystercard

  attr_reader :balance
  MINIMUM = 1
  LIMIT = 90
  def initialize
    @balance = 0
    @in_journey = false
  end
  def top_up(amount)
    raise "Limit is #{LIMIT}" if @balance + amount > LIMIT
    @balance += amount
  end
  def deduct(amount)
    @balance -= amount
  end
  def touch_in
      raise "Insufficient balance" if @balance < MINIMUM
    @in_journey = true
  end
  def touch_out
    deduct(MINIMUM)
    @in_journey = false
  end
  def in_journey?
    @in_journey
  end
end
