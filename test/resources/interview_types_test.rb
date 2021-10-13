# frozen_string_literal: true

require 'test_helper'

class InterviewTypesResourceTest < Minitest::Test
  def test_list
    stub = stub_request('interview-types', response: stub_response(fixture: 'interview_types/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    interview_types = client.interview_types.list

    assert_equal 1, interview_types.length
  end

  def test_create
    interview_types = ['case']
    stub = stub_request('interview-types',
                        method: :patch,
                        body: interview_types,
                        response: stub_response(fixture: 'interview_types/create', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.interview_types.create(interview_types: interview_types)
  end

  def test_delete
    interview_type = 'case'
    stub = stub_request("interview-types/#{interview_type}",
                        method: :delete,
                        response: stub_response(fixture: 'interview_types/delete', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.interview_types.delete(interview_type: interview_type)
  end
end
