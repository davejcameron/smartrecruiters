# frozen_string_literal: true

require 'test_helper'

class ReportsResourceTest < Minitest::Test
  REPORT_API = 'reporting-api/v201804/reports'

  def test_list
    stub = stub_request(REPORT_API.to_s, response: stub_response(fixture: 'reports/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    reports = client.reports.list

    assert_equal SmartRecruiters::Collection, reports.class
    assert_equal SmartRecruiters::Report, reports.content.first.class
    assert_equal 1, reports.content.length
  end

  def test_retrieve
    report_id = 'c446db17-bc04-4179-a1ff-5940904bbe6d'
    stub = stub_request("#{REPORT_API}/#{report_id}",
                        response: stub_response(fixture: 'reports/retrieve'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    report = client.reports.retrieve(report_id: report_id)

    assert_equal SmartRecruiters::Report, report.class
    assert_equal 'ANNUALLY', report.schedule['frequency']
  end

  def test_retrieve_files
    report_id = 'c446db17-bc04-4179-a1ff-5940904bbe6d'
    stub = stub_request("#{REPORT_API}/#{report_id}/files",
                        response: stub_response(fixture: 'reports/retrieve_files'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    reports = client.reports.retrieve_files(report_id: report_id)

    assert_equal SmartRecruiters::Collection, reports.class
    assert_equal SmartRecruiters::ReportFile, reports.content.first.class
    assert_equal 'PENDING', reports.content.first.reportFileStatus
  end

  def test_generate_report
    report_id = 'c446db17-bc04-4179-a1ff-5940904bbe6d'
    stub = stub_request("#{REPORT_API}/#{report_id}/files",
                        method: :post,
                        response: stub_response(fixture: 'reports/generate_report'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    report = client.reports.generate_report(report_id: report_id)

    assert_equal SmartRecruiters::Report, report.class
    assert_equal 'PENDING', report.reportFileStatus
  end

  def retrieve_recent_file
    report_id = 'c446db17-bc04-4179-a1ff-5940904bbe6d'
    stub = stub_request("#{REPORT_API}/#{report_id}/files/recent",
                        response: stub_response(fixture: 'reports/retrieve'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    file = client.reports.retrieve_recent_file(report_id: report_id)
    assert_equal SmartRecruiters::ReportFile, file.class
    assert_equal 'AD_HOC', file.scheduleType
  end

  def retrieve_recent_file_data
    report_id = 'c446db17-bc04-4179-a1ff-5940904bbe6d'
    stub = stub_request("#{REPORT_API}/#{report_id}/files/recent/data",
                        response: stub_response(fixture: 'reports/retrieve_recent_file_data'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    data = client.reports.retrieve_recent_file_data(report_id: report_id)
    assert_equal SmartRecruiters::Object, data.class
  end
end
