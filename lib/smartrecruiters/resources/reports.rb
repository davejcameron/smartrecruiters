# frozen_string_literal: true

module SmartRecruiters
  class ReportsResource < Resource
    REPORT_API = 'reporting-api/v201804/reports'
    def list(**params)
      response = get_request(REPORT_API.to_s, params: params)
      Collection.from_response(response, type: Report)
    end

    def retrieve(report_id:)
      Report.new get_request("#{REPORT_API}/#{report_id}").body
    end

    def retrieve_files(report_id:)
      response = get_request("#{REPORT_API}/#{report_id}/files")
      Collection.from_response(response, type: ReportFile)
    end

    def generate_report(report_id:)
      Report.new post_request("#{REPORT_API}/#{report_id}/files", body: {}).body
    end

    def retrieve_recent_file(report_id:)
      ReportFile.new get_request("#{REPORT_API}/#{report_id}/files/recent").body
    end

    def retrieve_recent_file_data(report_id:)
      response = get_request("#{REPORT_API}/#{report_id}/files/recent/data").body
      Object.new JSON.parse(response)
    end
  end
end
