class ForecastService < BaseService
  def self.call_forecast(location)
    response = conn('https://api.openweathermap.org/data/2.5/onecall').get do |req|
      req.params[:appid] = ENV['WEATHER_KEY']
      req.params[:lat] = location.lat
      req.params[:lon] = location.lng
      req.params[:units] = 'imperial'
      req.params[:exclude] = 'minutely,alerts'
    end
    parse(response)
  end
end
