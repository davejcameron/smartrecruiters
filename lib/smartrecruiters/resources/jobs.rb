module SmartRecruiters
  class JobsResource < Resource
    def list(**params)
      response = get_request("jobs", params: params)
      Collection.from_response(response, type: Job)
    end

    def retrieve(job_id:)
      Job.new get_request("jobs/#{job_id}").body
    end

    def list_hiring_team(job_id:)
      response = get_request("jobs/#{job_id}/hiring-team")
      Collection.from_response(response, type: Object)
    end
  end
end