class BaseService
  class << self
    def conn(url)
      Faraday.new(url)
	  end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
