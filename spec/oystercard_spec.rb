require 'oystercard'

describe Oystercard do
  let(:oystercard) {Oystercard.new}
  let (:station){ double :station }

  context 'initialisation tests' do
    it 'has default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  context '#top_up' do
    let(:maximum_balance) {maximum_balance = Oystercard::MAXIMUM_BALANCE}
      it 'increases the balance' do
        expect{ subject.top_up(5) }.to change{ subject.balance }.by(5) 
       end

       it 'raises an error is the maximum balance is exceeded' do
          subject.top_up(maximum_balance)
          expect{ subject.top_up(5) }.to raise_error "ERROR: Maximum limit of #{maximum_balance} has been reached"
       end
  end

  context '#in_journey?' do
    it 'check whether oyster is currently in a journey' do
      expect(subject.in_journey?).to be(true).or be(false)
    end
  end 

  context "#touch_in" do
    it "begins journey" do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end

    it 'checks for minimum balance before check in' do
      expect { subject.touch_in(station) }.to raise_error 'Balance below minimum fare'
    end 

    it 'it stores the entry station' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end 
  end

  context '#touch_out' do
    it 'ends the journey' do
      subject.touch_out
      expect(subject.in_journey?).to be false
    end

    it 'charges balance for journey taken' do
      expect {subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end
end





 # before(:each) do 
    #   subject.top_up(5)
    # end
