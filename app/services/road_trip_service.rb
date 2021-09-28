class RoadTripService < BaseService
  def self.call_route(route)
    response = conn('https://www.mapquestapi.com/directions/v2/route').get do |req|
      req.params[:key] = ENV['MAPQUEST_KEY']
      req.params[:from] = route[:origin]
      req.params[:to] = route[:destination]
    end
    parse(response)
  end
end
