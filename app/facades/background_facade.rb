class BackgroundFacade
  def self.get_background(location)
    Image.new(BackgroundService.call_background(location))
  end
end