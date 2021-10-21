require 'station'

describe Station do
  let(:station) {Station.new("Waterloo", 1)}

  it 'Station class contains name of station' do
    expect(station.name).to eq "Waterloo"
  end

  it 'Station class contains zone' do
    expect(station.zone).to eq 1
  end
end