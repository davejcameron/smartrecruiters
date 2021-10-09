# frozen_string_literal: true

module SmartRecruiters
  class CandidatesResource < Resource
    def list(**params)
      response = get_request('candidates', params: params)
      Collection.from_response(response, type: Candidate)
    end

    def retrieve(candidate_id:)
      Candidate.new get_request("candidates/#{candidate_id}").body
    end

    def create(**attributes)
      Candidate.new post_request('candidates', body: attributes).body
    end

    def update(candidate_id:, **attributes)
      Candidate.new patch_request("candidates/#{candidate_id}", body: attributes).body
    end

    def delete(candidate_id:)
      delete_request("candidates/#{candidate_id}")
      true
    end

    def retrieve_consent(candidate_id:)
      Object.new get_request("candidates/#{candidate_id}/consent").body
    end

    def retrieve_consents(candidate_id:)
      response = get_request("candidates/#{candidate_id}/consents")
      Collection.from_response(response, type: Object.new)
    end

    def retrieve_application(candidate_id:, job_id:)
      Object.new get_request("candidates/#{candidate_id}/jobs/#{job_id}").body
    end

    def retrieve_application_attachments(candidate_id:, job_id:)
      response = get_request("candidates/#{candidate_id}/jobs/#{job_id}/attachments")
      Collection.from_response(response, type: Attachment)
    end

    def retrieve_status_history(candidate_id:, job_id:)
      Object.new get_request("candidates/#{candidate_id}/jobs/#{job_id}/status/history").body
    end
  end
end
