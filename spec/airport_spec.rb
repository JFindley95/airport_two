require 'airport.rb'
require 'plane.rb'
require 'weather.rb'

  describe Airport do
    let(:weather)  { double :weather, status: 'sunny' }
    let(:airport)  { Airport.new(5, weather) }
    let(:plane1)   { Plane.new("BA123") }
    let(:plane2)   { Plane.new("BA345") }
    let(:plane3)   { Plane.new("BA678") }

  describe '#land_plane' do
   it 'will instruct a plane to land' do
     airport.land_plane(plane1)
     expect(airport.hangar).to eq [plane1]
   end

   it 'will not allow a plane to land if the airport is full' do
     airport.land_plane(plane1)
     airport.land_plane(plane2)
     airport.land_plane(plane3)
     airport.land_plane(plane1)
     airport.land_plane(plane2)
     expect { airport.land_plane(plane3) }.to raise_error("the airports max capacity of #{airport.capacity} has been reached, do not land")
     end

     context 'when the weather is stormy' do
     let(:weather)  { double :weather, status: 'stormy' }
       it 'will NOT allow a plane to land' do
       expect { airport.land_plane(plane1) }.to raise_error("you can not land due to stormy weather")
       end
     end

     context 'when the weather is stormy and max capacity has been reached' do
         it 'will not allow landing' do
         airport.land_plane(plane1)
         airport.land_plane(plane2)
         airport.land_plane(plane3)
         airport.land_plane(plane1)
         airport.land_plane(plane2)
         allow(weather).to receive(:status) {'stormy'}
         expect { airport.land_plane(plane1) }.to raise_error("you can not land due to stormy conditions. Aiport is also full")
         end
       end
    end

   describe '#plane_take_off' do
    it 'will instruct a plane to take off' do
      airport.land_plane(plane1)
      airport.land_plane(plane3)
      airport.plane_take_off(plane3)
      expect(airport.hangar).not_to include("BA678")
      end

    context 'when the weather is stormy' do
      it 'will NOT allow a plane to take off' do
      airport.land_plane(plane1)
      airport.land_plane(plane2)
      allow(weather).to receive(:status) {'stormy'}
      expect { airport.plane_take_off(plane2) }.to raise_error("you can not fly due to bad weather")
      end
    end

    context 'when the weather is NOT stormy' do
      it 'WILL allow the plane to take off' do
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
