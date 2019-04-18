module PairguruMovies
  module V1
    class Client
      PairguruMoviesAPIError = Class.new(StandardError)
      BadRequestError = Class.new(PairguruMoviesAPIError)
      UnauthorizedError = Class.new(PairguruMoviesAPIError)
      ForbiddenError = Class.new(PairguruMoviesAPIError)
      ApiRequestsQuotaReachedError = Class.new(PairguruMoviesAPIError)
      NotFoundError = Class.new(PairguruMoviesAPIError)
      UnprocessableEntityError = Class.new(PairguruMoviesAPIError)
      ApiError = Class.new(PairguruMoviesAPIError)
      
      HTTP_OK_CODE = 200

      HTTP_BAD_REQUEST_CODE = 400
      HTTP_UNAUTHORIZED_CODE = 401
      HTTP_FORBIDDEN_CODE = 403
      HTTP_NOT_FOUND_CODE = 404
      HTTP_UNPROCESSABLE_ENTITY_CODE = 429

      API_ENDPOINT = 'https://pairguru-api.herokuapp.com/api/v1/movies/'.freeze

      def client
        @_client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
        end
      end

      def request(http_method:, endpoint:, params: {})
        response = client.public_send(http_method, endpoint, params)
        if response
          Oj.load(response.body)
        end
      end

      def response_successful?
        response.status == HTTP_OK_CODE
      end

      def api_requests_quota_reached?
        response.body.match?(API_REQUSTS_QUOTA_REACHED_MESSAGE)
      end
    end
  end
end