# frozen_string_literal: true

module SmartRecruiters
  class InterviewTypesResource < Resource
    def list
      Object.new get_request('interview-types').body
    end

    def create(interview_types:)
      patch_request('interview-types', body: interview_types)
      true
    end

    def delete(interview_type:)
      delete_request("interview-types/#{interview_type}")
      true
    end
  end
end
