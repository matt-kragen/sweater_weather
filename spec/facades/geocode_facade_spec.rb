require 'rails_helper'

RSpec.describe GeocodeFacade do
  describe 'location creation' do
    it 'creates Location object', :vcr do
      location = GeocodeFacade.retrieve_geocode('denver,co')
      expect(location).to be_a(Location)
    end

    it 'creates latitude and longitude using given city', :vcr do
      location = GeocodeFacade.retrieve_geocode('denver,co')
      expect(location.lat).to be_a(Float)
      expect(location.lng).to be_a(Float)
    end
  end
end
