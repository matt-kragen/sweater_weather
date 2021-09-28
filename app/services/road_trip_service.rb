class RoadTripService < BaseService
  def self.call_route(origin, destination)
    response = conn('https://www.mapquestapi.com/directions/v2/route').get do |req|
      req.params[:key] = ENV['MAPQUEST_KEY']
      req.params[:from] = origin
      req.params[:to] = destination
    end
    parse(response)
  end
end
