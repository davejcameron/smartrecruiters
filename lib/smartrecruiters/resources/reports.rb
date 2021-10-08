module SmartRecruiters
  class ReportsResource < Resource
    REPORT_API = 'reporting-api/v201804'
    def list(**params)
      response = get_request("#{REPORT_API}/reports", params: params)
      Collection.from_response(response, type: Report)
    end

    def retrieve(report_id:)
      Report.new get_request("#{REPORT_API}/reports/#{report_id}").body
    end
  end
end