require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'roadtrip creation' do
    it 'creates RoadTrip object', :vcr do
      params = { origin: 'denver,co', destination: 'pueblo,co' }
      road_trip = RoadTripFacade.get_route(params)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to eq('Denver,Co')
      expect(road_trip.end_city).to eq('Pueblo,Co')
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta[:temperature]).to be_a(Numeric)
      expect(road_trip.weather_at_eta[:conditions]).to be_a(String)
    end
  end
end
