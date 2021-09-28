require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'instance creation' do
    it 'exists and has attributes' do
      route_json = File.read('./spec/fixtures/json_fixtures/route.json')
      parsed_route_json = JSON.parse(route_json, symbolize_names: true)
      
      forecast_json = File.read('./spec/fixtures/json_fixtures/denver_forecast.json')
      parsed_forecast_json = JSON.parse(forecast_json, symbolize_names: true)
      
      locations = { origin: 'vista,ca', destination: 'denver,co' }
      road_trip = RoadTrip.new(locations, parsed_route_json, parsed_forecast_json)

      expect(road_trip).to be_an(RoadTrip)
      expect(road_trip.start_city).to eq('Vista,Ca')
      expect(road_trip.end_city).to eq('Denver,Co')
      expect(road_trip.travel_time).to eq('14:53:21')
      expect(road_trip.weather_at_eta).to eq({:temperature=>65.98, :conditions=>"Clear"})
    end
  end

  describe 'class methods' do
    describe '::predicted_weather' do
      it 'predicts average weather 3 days in advance' do
        route_json = File.read('./spec/fixtures/json_fixtures/long_route.json')
        parsed_route_json = JSON.parse(route_json, symbolize_names: true)
        
        forecast_json = File.read('./spec/fixtures/json_fixtures/denver_forecast.json')
        parsed_forecast_json = JSON.parse(forecast_json, symbolize_names: true)
        
        # Average of day 3 values
        day_3 = {
                  "day": 83.46,
                  "min": 67.42,
                  "max": 87.01,
                  "night": 73.89,
                  "eve": 85.06,
                  "morn": 67.86
                }
        expect(day_3.values.sum / day_3.values.size).to eq(77.45)

        locations = { origin: 'anchorage,alaska', destination: 'pensacola,fl' }
        road_trip = RoadTrip.new(locations, parsed_route_json, parsed_forecast_json)

        expect(road_trip).to be_an(RoadTrip)
        expect(road_trip.start_city).to eq('Anchorage,Alaska')
        expect(road_trip.end_city).to eq('Pensacola,Fl')
        expect(road_trip.travel_time).to eq('72:58:18')
        expect(road_trip.weather_at_eta).to eq({:temperature=>77.45, :conditions=>"Clouds"})
      end
    end
  end
end
