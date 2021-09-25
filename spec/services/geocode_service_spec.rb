require 'rails_helper'

RSpec.describe GeocodeService do
  describe 'connection' do
    it 'can make a connection to external service' do
      connection = GeocodeService.conn('http://www.mapquestapi.com/geocoding/v1/address')
      expect(connection).to be_an_instance_of(Faraday::Connection)
    end
  end

  describe 'class methods' do
    describe '::get_geocode' do
      it 'returns geocode for a given location', :vcr do
        params = { location: 'denver,co' }
        response = GeocodeService.call_geocode(params[:location])

        expect(response).to be_a(Hash)
        expect(response).to have_key(:info)

        expect(response).to have_key(:options)
        expect(response[:options][:maxResults]).to eq(1)

        expect(response).to have_key(:results)
        expect(response[:results]).to be_an(Array)

        expect(response[:results][0]).to have_key(:providedLocation)
        expect(response[:results][0][:providedLocation][:location]).to eq('denver,co')
        
        expect(response[:results][0]).to have_key(:locations)
        expect(response[:results][0][:locations]).to be_an(Array)
        
        expect(response[:results][0][:locations][0]).to have_key(:latLng)
        expect(response[:results][0][:locations][0][:latLng]).to be_a(Hash)

        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a(Numeric)
        
        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a(Numeric)
      end
    end
  end
end