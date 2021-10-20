class Oystercard
attr_reader :balance
attr_accessor :in_journey
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise_limit_error?(amount)
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail 'Balance below minimum fare' if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

private

  def deduct(fare)
    @balance -= fare
  end

  def raise_limit_error?(amount)
    raise "ERROR: Maximum limit of #{MAXIMUM_BALANCE} has been reached" if @balance + amount > MAXIMUM_BALANCE
  end

end