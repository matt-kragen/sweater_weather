class Image
  attr_reader :url, :images, :credits

  def initialize(data)
    @url = data[:photos][0][:url]
    @images = data[:photos][0][:src]
    @credits = {
      pexels_credit: 'Photo provided by Pexels',
      pexels_link: 'https://www.pexels.com',
      photographer: data[:photos][0][:photographer]
    }
  end
end