# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'json'

module SmartRecruiters
  class Client
    SMART_RECRUITERS_TIMEOUT = 128
    SMART_RECRUITERS_RETRIES = 3

    SMART_RECRUITERS_BASE_PATHS = {
      'production' => 'https://api.smartrecruiters.com',
      'sandbox' => 'https://api.sandbox.smartrecruiters.com'
    }.freeze

    attr_reader :api_key, :adapter

    def initialize(
      api_key:,
      adapter: Faraday.default_adapter,
      stubs: nil,
      environment: 'production'
    )
      @api_key = api_key
      @environment = environment

      @adapter = adapter
      @stubs = stubs
    end

    def access_groups
      AccessGroupsResource.new(self)
    end

    def candidates
      CandidatesResource.new(self)
    end

    def interview_types
      InterviewTypesResource.new(self)
    end

    def interviews
      InterviewsResource.new(self)
    end

    def jobs
      JobsResource.new(self)
    end

    def offers
      OffersResource.new(self)
    end

    def postings
      PostingsResource.new(self)
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

    def webhooks
      WebhooksResource.new(self)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = SMART_RECRUITERS_BASE_PATHS[@environment]
        conn.headers['X-SmartToken'] = api_key
        conn.request :json
        conn.request :retry, retry_options

        conn.response :json, content_type: 'application/json'

        conn.options.timeout = SMART_RECRUITERS_TIMEOUT
        conn.adapter adapter, @stubs
      end
    end

    private

    def retry_options
      {
        max: SMART_RECRUITERS_RETRIES,
        retry_statuses: [429]
      }
    end
  end
end
