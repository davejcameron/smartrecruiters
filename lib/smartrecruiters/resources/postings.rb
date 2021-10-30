# frozen_string_literal: true

module SmartRecruiters
  class PostingsResource < Resource
    COMPANY_API = 'v1/companies'

    def list(company_id:, **params)
      response = get_request("#{COMPANY_API}/#{company_id}/postings", params: params)
      Collection.from_response(response, type: Posting)
    end

    def list_departments(company_id:, **params)
      response = get_request("#{COMPANY_API}/#{company_id}/departments", params: params)
      Collection.from_response(response, type: Department)
    end

    def retrieve_posting(company_id:, posting_id:, **params)
      Posting.new get_request("#{COMPANY_API}/#{company_id}/postings/#{posting_id}", params: params).body
    end

    def create_candidate(posting_id:, **attributes)
      Object.new post_request("postings/#{posting_id}/candidates", body: attributes).body
    end

    def retrieve_candidate_status(posting_id:, candidate_id:)
      Object.new get_request("postings/#{posting_id}/candidates/#{candidate_id}/status").body
    end

    def retrieve_configuration(posting_id:)
      Object.new get_request("postings/#{posting_id}/configuration").body
    end
  end
end
