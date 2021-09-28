class RoadTripService < BaseService
  def self.call_route(locations)
    response = conn('https://www.mapquestapi.com/directions/v2/route').get do |req|
      req.params[:key] = ENV['MAPQUEST_KEY']
      req.params[:from] = locations[:origin]
      req.params[:to] = locations[:destination]
    end
    parse(response)
  end
end
