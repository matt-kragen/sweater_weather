class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather
              
  def initialize(data)
    @current_weather = {
      datetime: Time.at(data[:current][:dt]).strftime('%a %b %e, %H:%M'),
      sunrise: Time.at(data[:current][:sunrise]).strftime('%a %b %e, %H:%M'),
      sunset: Time.at(data[:current][:sunset]).strftime('%a %b %e, %H:%M'),
      temp: data[:current][:temp],
      feels_like: data[:current][:feels_like],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uvi],
      visibility: data[:current][:visibility],
      conditions: data[:current][:weather][0][:description],
      icon: data[:current][:weather][0][:icon]
    }
    @daily_weather = data[:daily][0..4].map { |day| {
      date: Time.at(day[:dt]).strftime('%b %d, %Y'),
      sunrise: Time.at(day[:sunrise]).strftime('%a %b %e, %H:%M'),
      sunset: Time.at(day[:sunset]).strftime('%a %b %e, %H:%M'),
      max_temp: day[:temp][:max],
      min_temp: day[:temp][:min],
      conditions: day[:weather][0][:description],
      icon: day[:weather][0][:icon]}
    }
    @hourly_weather = data[:hourly][0..7].map { |hour| {
      time: Time.at(hour[:dt]).strftime('%H:%M:%S'),
      temp: hour[:temp],
      conditions: hour[:weather][0][:description],
      icon: hour[:weather][0][:icon]}
    }
  end
end