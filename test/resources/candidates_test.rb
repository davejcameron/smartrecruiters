# frozen_string_literal: true

require 'test_helper'

class CandidatesResourceTest < Minitest::Test
  def test_list
    stub = stub_request('candidates', response: stub_response(fixture: 'candidates/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    candidates = client.candidates.list

    assert_equal SmartRecruiters::Collection, candidates.class
    assert_equal SmartRecruiters::Candidate, candidates.content.first.class
    assert_equal 1, candidates.content.length
  end

  def test_retrieve
    candidate_id = 'f4233cb7-fb62-4b5a-9e00-05710425bfb8'
    stub = stub_request("candidates/#{candidate_id}",
                        response: stub_response(fixture: 'candidates/retrieve'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    candidate = client.candidates.retrieve(candidate_id: candidate_id)

    assert_equal SmartRecruiters::Candidate, candidate.class
    assert_equal 'First', candidate.firstName
  end

  def test_create
    body = {
      firstName: 'First', lastName: 'string', email: 'create@example.com', phoneNumber: 'string',
      location: { country: 'string', countryCode: 'string', regionCode: 'string',
                  region: 'string', city: 'string', lat: 0, lng: 0 },
      web: { skype: 'string', linkedin: 'string', facebook: 'string', twitter: 'string', website: 'string' },
      tags: ['string'],
      education: [{ institution: 'string', degree: 'string', major: 'string', current: true, location: 'string',
                    startDate: 'string', endDate: 'string', description: 'string' }],
      experience: [{ title: 'string', company: 'string', current: true,
                     startDate: 'string', endDate: 'string', location: 'string', description: 'string' }],
      sourceDetails: { sourceTypeId: 'string', sourceSubTypeId: 'string', sourceId: 'string' },
      internal: true
    }
    stub = stub_request('candidates',
                        method: :post, body: body,
                        response: stub_response(fixture: 'candidates/create', status: 201))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    candidate = client.candidates.create(**body)

    assert_equal SmartRecruiters::Candidate, candidate.class
    assert_equal 'First', candidate.firstName
  end

  def test_update
    candidate_id = 'f4233cb7-fb62-4b5a-9e00-05710425bfb8'
    body = {
      firstName: 'Updated', lastName: 'string', email: 'user@example.com', phoneNumber: 'string',
      location: { country: 'string', countryCode: 'string', regionCode: 'string',
                  region: 'string', city: 'string', lat: 0, lng: 0 },
      web: { skype: 'string', linkedin: 'string', facebook: 'string', twitter: 'string', website: 'string' }
    }
    stub = stub_request("candidates/#{candidate_id}",
                        method: :patch, body: body,
                        response: stub_response(fixture: 'candidates/update', status: 200))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    candidate = client.candidates.update(candidate_id: candidate_id, **body)

    assert_equal SmartRecruiters::Candidate, candidate.class
    assert_equal 'Updated', candidate.firstName
  end

  def test_delete
    candidate_id = 'f4233cb7-fb62-4b5a-9e00-05710425bfb8'
    stub = stub_request("candidates/#{candidate_id}",
                        method: :delete,
                        response: stub_response(fixture: 'candidates/delete', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.candidates.delete(candidate_id: candidate_id)
  end

  def test_retrieve_consent
    candidate_id = 'f4233cb7-fb62-4b5a-9e00-05710425bfb8'
    stub = stub_request("candidates/#{candidate_id}/consent",
                        response: stub_response(fixture: 'candidates/retrieve_consent'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    consent = client.candidates.retrieve_consent(candidate_id: candidate_id)

    assert_equal SmartRecruiters::Object, consent.class
    assert_equal 'REQUIRED', consent.status
  end

  def test_retrieve_consents
    candidate_id = 'f4233cb7-fb62-4b5a-9e00-05710425bfb8'
    stub = stub_request("candidates/#{candidate_id}/consents",
                        response: stub_response(fixture: 'candidates/retrieve_consents'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    consents = client.candidates.retrieve_consents(candidate_id: candidate_id)

    assert_equal SmartRecruiters::Object, consents.class
    assert_equal 'acquired', consents.decisions.first['status']
  end

  def test_retrieve_application
    candidate_id = 'f4233cb7-fb62-4b5a-9e00-05710425bfb8'
    job_id = '463cfaf8-5d4f-49aa-925c-f4d4152a1b2e'
    stub = stub_request("candidates/#{candidate_id}/jobs/#{job_id}",
                        response: stub_response(fixture: 'candidates/retrieve_application'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    application = client.candidates.retrieve_application(candidate_id: candidate_id, job_id: job_id)

    assert_equal SmartRecruiters::Object, application.class
    assert_equal 'LEAD', application.status
  end

  def test_retrieve_application_attachments
    candidate_id = 'f4233cb7-fb62-4b5a-9e00-05710425bfb8'
    job_id = '463cfaf8-5d4f-49aa-925c-f4d4152a1b2e'
    stub = stub_request("candidates/#{candidate_id}/jobs/#{job_id}/attachments",
                        response: stub_response(fixture: 'candidates/retrieve_application_attachments'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    attachments = client.candidates.retrieve_application_attachments(candidate_id: candidate_id, job_id: job_id)

    assert_equal SmartRecruiters::Collection, attachments.class
    assert_equal SmartRecruiters::Attachment, attachments.content.first.class
    assert_equal 1, attachments.content.length
  end

  def test_retrieve_status_history
    candidate_id = 'f4233cb7-fb62-4b5a-9e00-05710425bfb8'
    job_id = '463cfaf8-5d4f-49aa-925c-f4d4152a1b2e'
    stub = stub_request("candidates/#{candidate_id}/jobs/#{job_id}/status/history",
                        response: stub_response(fixture: 'candidates/retrieve_status_history'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    status_history = client.candidates.retrieve_status_history(candidate_id: candidate_id, job_id: job_id)

    assert_equal SmartRecruiters::Collection, status_history.class
    assert_equal SmartRecruiters::Object, status_history.content.first.class
    assert_equal 'LEAD', status_history.content.first.status
  end
end
