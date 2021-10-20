class Oystercard
attr_reader :balance, :entry_station, :journey, :exit_station, :journeys
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
  def initialize
    @balance = 0
    @journeys = []
    @journey = {}
  end

  def top_up(amount)
    raise_limit_error?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    fail 'Balance below minimum fare' if @balance < MINIMUM_FARE
    @entry_station = entry_station
    @journey[:entry_station] = @entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    @journey[:exit_station] = @exit_station
    @entry_station = nil
    @journeys.push(journey)
  end

private

  def deduct(fare)
    @balance -= fare
  end

  def raise_limit_error?(amount)
    raise "ERROR: Maximum limit of #{MAXIMUM_BALANCE} has been reached" if @balance + amount > MAXIMUM_BALANCE
  end

end