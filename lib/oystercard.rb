class Oystercard
attr_reader :balance, :entry_station
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise_limit_error?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail 'Balance below minimum fare' if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

private

  def deduct(fare)
    @balance -= fare
  end

  def raise_limit_error?(amount)
    raise "ERROR: Maximum limit of #{MAXIMUM_BALANCE} has been reached" if @balance + amount > MAXIMUM_BALANCE
  end

end