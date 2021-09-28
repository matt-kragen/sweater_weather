require 'rails_helper'

RSpec.describe RoadTripService do
  describe 'connection' do
    it 'can make a connection to external service' do
      connection = RoadTripService.conn('https://www.mapquestapi.com/directions/v2/route')
      expect(connection).to be_an_instance_of(Faraday::Connection)
    end
  end

  describe 'class methods' do
    it '::call_route', :vcr do
      params = { origin: 'denver,co', destination: 'pueblo,co' }
      route_response = RoadTripService.call_route(params)

      expect(route_response).to be_a(Hash)
      expect(route_response.keys).to eq([:route, :info])
       
      expect(route_response[:route]).to be_a(Hash)
      expect(route_response[:route]).to have_key(:formattedTime)
      expect(route_response[:route][:formattedTime]).to be_a(String) 
       
      expect(route_response[:info]).to be_a(Hash)
      expect(route_response[:info]).to have_key(:statuscode)
      expect(route_response[:info][:statuscode]).to eq(0)
    end
  end
end
