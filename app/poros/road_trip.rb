class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(locations, route_info, weather_info)
    @start_city = locations[:origin].titleize
    @end_city = locations[:destination].titleize
    @travel_time = route_info[:route][:formattedTime]
    @weather_at_eta = predicted_weather(weather_info)
  end

  def time_splitter
    @travel_time.split(':').map do |time|
      time.to_i
    end
  end

  def days(hours)
    (hours / 24).round()
  end

  def predicted_weather(weather_info)
    if time_splitter[0] < 48
      @weather_at_eta = {
        temperature: weather_info[:hourly][time_splitter[0] - 1][:temp],
        conditions: weather_info[:hourly][time_splitter[0] - 1][:weather][0][:main]
      }
    else
      @weather_at_eta = {
        temperature: weather_info[:daily][days(time_splitter[0]) - 1][:temp].values.sum / weather_info[:daily][days(time_splitter[0])][:temp].values.size,
        conditions: weather_info[:daily][days(time_splitter[0]) - 1][:weather][0][:main]
      }
    end
  end
end