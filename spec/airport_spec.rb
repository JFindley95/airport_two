require 'airport.rb'
require 'plane.rb'
require 'weather.rb'

  describe Airport do
    let(:airport)  { Airport.new }
    let(:plane1)   { Plane.new("BA123") }
    let(:plane2)   { Plane.new("BA345") }
    let(:plane3)   { Plane.new("BA678") }
    # let(:weather)  { double('cloudy') }

  describe '#land_plane' do
   it 'will instruct a plane to land' do
     srand(2)
     airport.land_plane(plane1)
     expect(airport.hangar).to eq [plane1]
   end

   it 'will not allow a plane to land if the airport is full' do
     srand(2)
     # airport.land_plane(plane1)
     # airport.land_plane(plane1) <<<< not sure why this wont work - I have set the weather to "cloudy" but for some reason it still wont allow this????
     # airport.land_plane(plane1)
     # airport.land_plane(plane1)
     # airport.land_plane(plane1)
     airport.hangar << (plane1)
     airport.hangar << (plane2)
     airport.hangar << (plane3)
     airport.hangar << (plane1)
     airport.hangar << (plane2)
     expect { airport.land_plane(plane3) }.to raise_error("the airports max capacity of #{airport.capacity} has been reached, do not land")
     end

     context 'when the weather is stormy' do
     it 'will NOT allow a plane to land' do
     srand(1)
     expect { airport.land_plane(plane1) }.to raise_error("you can not land due to stormy weather")
     end
   end
     context 'when the weather is stormy and max capacity has been reached' do
     it 'will not allow landing' do
     srand(1)
     airport.weather
     airport.hangar << (plane1)
     airport.hangar << (plane2)
     airport.hangar << (plane3)
     airport.hangar << (plane1)
     airport.hangar << (plane2)
     expect { airport.land_plane(plane1) }.to raise_error("you can not land due to stormy conditions. Aiport is also full")
     end
     end
  end

   describe '#plane_take_off' do
    it 'will instruct a plane to take off' do
      srand(3)
      airport.land_plane(plane1)
      airport.land_plane(plane3)
      airport.plane_take_off(plane3)
      expect(airport.hangar).not_to include("BA678")
      end
    context 'when the weather is stormy' do
      it 'will NOT allow a plane to take off' do
      srand(1)
      airport.hangar << (plane1)
      airport.hangar << (plane2)
      expect { airport.plane_take_off(plane2) }.to raise_error("you can not fly due to bad weather")
      end
    end

    context 'when the weather is NOT stormy' do
      it 'WILL allow the plane to take off' do
      srand(2)
      airport.land_plane(plane1)
      airport.plane_take_off(plane1)
      expect(airport.hangar).to eq []
      end
    end
  end

  describe 'override_max_capacity' do
    it 'I can override the max capacity' do
      airport.override_max_capacity(20)
      expect(airport.capacity).to eq(20)
    end
  end
end
