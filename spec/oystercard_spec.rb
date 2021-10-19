require 'oystercard'
describe Oystercard do
  let(:oystercard) {Oystercard.new}
  context 'initialisation tests' do
    it 'class can be called and created' do
      expect(oystercard).to eq oystercard
    end
    it 'has default balance of 0' do
      expect(subject.balance).to eq(0)
  end
end
  context '#top_up' do
    let(:maximum_balance) {maximum_balance = Oystercard::MAXIMUM_BALANCE}
    it 'increases the balance' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by(5) 
    end
    it 'Deposits of more than £90 raise error' do
      expect{ subject.top_up(91) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
    it 'raises an error is the maximum balance is exceeded' do
      subject.top_up(maximum_balance)
      expect{ subject.top_up(5) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end
  context '#deduct' do
    it 'deducts the cost of trip from balance' do
      expect{ subject.deduct(4) }.to change{ subject.balance }.by(-4)
    end
  end
  context '#in_journey?' do
    it 'check whether oyster is currently in a journey' do
      expect(subject.in_journey?).to be(true).or be(false)
    end
    context '#touch_in' do
      it 'begins journey' do
        subject.top_up(5)
        subject.touch_in
        expect(subject.in_journey?).to be true
      end
      it 'checks for minimum balance before check in' do
        expect { subject.touch_in }.to raise_error 'Balance below minimum fare'
      end 
    end
    context '#touch_out' do
      it 'ends the journey' do
        subject.touch_out
        expect(subject.in_journey?).to be false
      end
    end
  end
end