require 'rails_helper'

RSpec.describe RoadTripService do
  describe 'connection' do
    it 'can make a connection to external service' do
      connection = RoadTripService.conn('https://www.mapquestapi.com/directions/v2/route')
      expect(connection).to be_an_instance_of(Faraday::Connection)
    end
  end
end