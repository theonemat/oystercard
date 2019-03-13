# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_list
  MINIMUM = 1
  LIMIT = 90
  def initialize
    @balance = 0
    @in_journey = false
    @journey_list = []
  end

  def top_up(amount)
    raise "Limit is #{LIMIT}" if @balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(entry_station)
    @entry_station = entry_station
    raise 'Insufficient balance' if @balance < MINIMUM
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    add_journey
    deduct(MINIMUM)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

#private
def add_journey
    @journey_list << {entry_station: @entry_station , exit_station: @exit_station}
  end

  def deduct(amount)
    @balance -= amount
  end
end
