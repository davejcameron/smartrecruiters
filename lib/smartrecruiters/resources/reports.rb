# frozen_string_literal: true

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

    def retrieve_files(report_id:)
      Object.new get_request("#{REPORT_API}/reports/#{report_id}/files").body
    end

    def generate_report(report_id:)
      Report.new post_request("#{REPORT_API}/reports/#{report_id}").body
    end

    def retrieve_recent_file(report_id:)
      Report.new get_request("#{REPORT_API}/reports/#{report_id}/files/recent").body
    end

    def retrieve_recent_file_data(report_id:)
      response = get_request("#{REPORT_API}/reports/#{report_id}/files/recent/data").body
      Object.new JSON.parse(response)
    end
  end
end
