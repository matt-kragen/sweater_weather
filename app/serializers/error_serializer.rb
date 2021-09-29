class ErrorSerializer
  class << self
    def missing_location
      {
        "message": "Location must be present",
        "status": "Bad Request"
      }
    end
    
    def invalid_params
      {
        "message": "Only location will be accepted",
        "status": "Bad Request"
      }
    end
  end
end