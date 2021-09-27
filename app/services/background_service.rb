class BackgroundService < BaseService
  def self.call_background(location)
    response = conn("https://api.pexels.com/v1/search").get do |req|
      req.params[:query] = location
      req.params[:per_page] = 1
      req.params[:orientation] = 'landscape'
      req.headers[:authorization] = ENV['PEXELS_KEY']
    end
    parse(response)
  end
end