# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :entry_station
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

  def touch_in(station)
    @entry_station = station
    raise 'Insufficient balance' if @balance < MINIMUM
  end

  def touch_out
    deduct(MINIMUM)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

# private

  def deduct(amount)
    @balance -= amount
  end
end
