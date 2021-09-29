class ErrorSerializer
  class << self
    def missing_location
      {
        "message": 'Location must be present',
        "status": 'Bad Request'
      }
    end

    def invalid_params
      {
        "message": 'Only location will be accepted',
        "status": 'Bad Request'
      }
    end

    def invalid_credentials
      {
        "message": 'Those credentials are invalid',
        "status": 'Unauthorized'
      }
    end

    def bad_format
      {
        "message": 'Payload must be JSON format',
        "status": 'Unsupported Media Type'
      }
    end

    def invalid_api_key
      {
        "message": 'Invalid API Key',
        "status": 'Unauthorized'
      }
    end
  end
end
