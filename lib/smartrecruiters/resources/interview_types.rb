# frozen_string_literal: true

module SmartRecruiters
  class InterviewTypesResource < Resource
    def list
      get_request('interview-types').body
    end

    def create(interview_types:)
      patch_request('interview-types', body: interview_types)
    end

    def delete(interview_type:)
      delete_request("interview-types/#{interview_type}")
    end
  end
end
