class ForecastService < BaseService
  def self.retrieve_forecast(location)
    response = conn.get("https://api.openweathermap.org/data/2.5/onecall") do |req|
      req.params[:appid] = ENV['weather_key']
      req.params[:lat] = location.lat
      req.params[:lon] = location.lng
      req.params[:units] = 'imperial'
      req.params[:exclude] = 'minutely'
    end
    parse(response)
  end
end