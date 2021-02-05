require 'weather.rb'
  describe Weather do
    let(:weather) { Weather.new }
    describe '#status' do
    it 'will return a random weather output when called' do
      srand(1)
      expect(weather.status).to eq "stormy"
      srand(2)
      expect(weather.status).to eq "cloudy"
      srand(3)
      expect(weather.status).to eq "sunny"
    end
  end
end
