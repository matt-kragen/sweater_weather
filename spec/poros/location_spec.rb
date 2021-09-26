require 'rails_helper'

RSpec.describe Location do
  describe 'instance creation' do
    it 'exists and has attributes' do
      attributes = {
        "results": [
          {
            "providedLocation": {
              "location": "denver,co"
            },
            "locations": [
              {
                "latLng": {
                  "lat": 39.738453,
                  "lng": -104.984853
                }
              }
            ]
          }
        ]
      }
      location = Location.new(attributes)
      expect(location).to be_a(Location)
      expect(location.lat).to eq(39.738453)
      expect(location.lng).to eq(-104.984853)
    end
  end
end