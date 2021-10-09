require 'faraday'
require 'faraday_middleware'

module SmartRecruiters
  class Client
    SMART_RECRUITERS_BASE_PATHS = {
      'production' => 'https://api.smartrecruiters.com',
      'sandbox' => 'https://api.sandbox.smartrecruiters.com'
    }

    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil, environment: 'production')
      @api_key = api_key
      @adapter = adapter
      @environment = environment

      @stubs = stubs
    end

    def access_groups
      AccessGroupsResource.new(self)
    end

    def candidates
      CandidatesResource.new(self)
    end

    def interviews
      InterviewsResource.new(self)
    end

    def jobs
      JobsResource.new(self)
    end

    def reports
      ReportsResource.new(self)
    end

    def reviews
      ReviewsResource.new(self)
    end

    def system_roles
      SystemRolesResource.new(self)
    end

    def users
      UsersResource.new(self)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = SMART_RECRUITERS_BASE_PATHS[@environment]
        conn.headers['X-SmartToken'] = api_key
        conn.request :json

        conn.response :json, content_type: 'application/json'

        conn.adapter adapter, @stubs
      end
    end
  end
end
