require 'oystercard'
describe Oystercard do
  let(:oystercard) {Oystercard.new}
  context 'Oystercard initialisation tests' do
    it 'class can be called and created' do
      expect(oystercard).to eq oystercard
    end
    it 'has default balance of 0' do
      expect(subject.balance).to eq(0)
  end
  context '#top_up' do
    it 'increases the balance' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by(5) 
    end
  end
end
end