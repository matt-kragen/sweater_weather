class GeocodeService < BaseService
  def self.call_geocode(location)
    response = conn('http://www.mapquestapi.com/geocoding/v1/address').get do |req|
      req.params[:key] = ENV['MAPQUEST_KEY']
      req.params[:location] = location
      req.params[:maxResults] = 1
    end
    parse(response)
  end
end
