class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @current_weather = {
      datetime: Time.at(data[:current][:dt]).strftime('%Y-%m-%e %H:%M:%S %z'),
      sunrise: Time.at(data[:current][:sunrise]).strftime('%Y-%m-%e %H:%M:%S %z'),
      sunset: Time.at(data[:current][:sunset]).strftime('%Y-%m-%e %H:%M:%S %z'),
      temp: data[:current][:temp],
      feels_like: data[:current][:feels_like],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uvi],
      visibility: data[:current][:visibility],
      conditions: data[:current][:weather][0][:description],
      icon: data[:current][:weather][0][:icon]
    }
    @daily_weather = data[:daily][0..4].map do |day|
      {
        date: Time.at(day[:dt]).strftime('%Y-%m-%e'),
        sunrise: Time.at(day[:sunrise]).strftime('%Y-%m-%e %H:%M:%S %z'),
        sunset: Time.at(day[:sunset]).strftime('%Y-%m-%e %H:%M:%S %z'),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather][0][:description],
        icon: day[:weather][0][:icon]
      }
    end
    @hourly_weather = data[:hourly][0..7].map do |hour|
      {
        time: Time.at(hour[:dt]).strftime('%H:%M:%S'),
        temp: hour[:temp],
        conditions: hour[:weather][0][:description],
        icon: hour[:weather][0][:icon]
      }
    end
  end
end
