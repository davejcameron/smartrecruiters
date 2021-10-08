module SmartRecruiters
  class InterviewsResource < Resource

    INTERVIEWS_API = "interviews-api/v201904"

    def create(**attributes)
      Interview.new post_request("#{INTERVIEWS_API}/interviews", body: attributes).body
    end

    def retrieve(interview_id:)
      Interview.new get_request("#{INTERVIEWS_API}/interviews/#{interview_id}").body
    end

    def update(interview_id:, **attributes)
      put_request("#{INTERVIEWS_API}/interviews/#{interview_id}", body: attributes)
      true
    end

    def delete(interview_id:)
      delete_request("#{INTERVIEWS_API}/interviews/#{interview_id}")
      true
    end
  end
end