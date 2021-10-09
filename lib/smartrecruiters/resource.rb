module SmartRecruiters
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    private

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, headers)
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, headers)
    end

    def patch_request(url, body:, headers: {})
      handle_response client.connection.patch(url, body, headers)
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, body, headers)
    end

    def delete_request(url, params: {}, headers: {})
      handle_response client.connection.delete(url, params, headers)
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, 'Bad request.'
      when 401
        raise Error, 'Unauthorized'
      when 403
        raise Error, 'Forbidden'
      when 404
        raise Error, 'Not Found'
      when 429
        raise Error, 'Too many requests'
      when 500
        raise Error, 'Internal Server Error'
      end

      response
    end
  end
end
