class BaseService
  def self.conn(url)
    Faraday.new(url)
	end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
