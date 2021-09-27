require 'rails_helper'

RSpec.describe Location do
  describe 'instance creation' do
    it 'exists and has attributes' do
      json = File.read('./spec/fixtures/json_fixtures/image.json')
      parsed_json = JSON.parse(json, symbolize_names: true)
      image = Image.new(parsed_json)

      expect(image).to be_an(Image)
      expect(image.url).to eq('https://www.pexels.com/photo/union-station-building-2706750/')
      expect(image.images).to be_a(Hash)
      expect(image.images.keys.count).to eq(8)
      expect(image.credits).to eq({
        pexels_credit: "Photo provided by Pexels",
        pexels_link: "https://www.pexels.com",
        photographer: "Thomas Ward"
      })
    end
  end
end