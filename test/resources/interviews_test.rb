# frozen_string_literal: true

require 'test_helper'

class InterviewsResourceTest < Minitest::Test
  INTERVIEWS_API = 'interviews-api/v201904/interviews'
  def test_create
    body = {
      candidate: { id: 'string', status: 'accepted' },
      jobId: 'string', location: 'string', organizerId: 'string', timezone: 'string',
      timeslots: [
        {
          interviewType: 'string', title: 'string', place: 'string',
          startsOn: '2021-10-13T19:07:20.116Z', endsOn: '2021-10-13T19:07:20.116Z',
          interviewers: [{ id: 'string', status: 'accepted' }]
        }
      ],
      createdOn: '2021-10-13T19:07:20.116Z', refUrl: 'string'
    }
    stub = stub_request(INTERVIEWS_API.to_s,
                        method: :post, body: body,
                        response: stub_response(fixture: 'interviews/create', status: 201))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    interview = client.interviews.create(**body)

    assert_equal SmartRecruiters::Interview, interview.class
    assert_equal 'dedc1f22-fa8e-4a41-acbd-41acc0607d7f', interview.id
  end

  def test_retrieve
    interview_id = 'bfaaf864-df89-4cda-8bda-5c6b624fa9e7'
    stub = stub_request("#{INTERVIEWS_API}/#{interview_id}",
                        response: stub_response(fixture: 'interviews/retrieve'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    interview = client.interviews.retrieve(interview_id: interview_id)

    assert_equal SmartRecruiters::Interview, interview.class
    assert_equal 'accepted', interview.candidate.status
  end

  def test_update
    interview_id = 'bfaaf864-df89-4cda-8bda-5c6b624fa9e7'
    body = {
      location: 'Online',
      timezone: 'string',
      candidate: {
        status: 'accepted'
      }
    }
    stub = stub_request("#{INTERVIEWS_API}/#{interview_id}",
                        method: :patch, body: body,
                        response: stub_response(fixture: 'interviews/update', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.interviews.update(interview_id: interview_id, **body)
  end

  def test_delete
    interview_id = 'bfaaf864-df89-4cda-8bda-5c6b624fa9e7'
    stub = stub_request("#{INTERVIEWS_API}/#{interview_id}",
                        method: :delete,
                        response: stub_response(fixture: 'interviews/delete', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.interviews.delete(interview_id: interview_id)
  end
end
