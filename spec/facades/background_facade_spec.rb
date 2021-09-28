require 'rails_helper'

RSpec.describe BackgroundFacade do
  describe 'background creation' do
    it 'creates background object', :vcr do
      query = { location: 'denver' }
      background = BackgroundFacade.get_background(query[:location])
      expect(background).to be_an(Image)
    end
  end
end
