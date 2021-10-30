# frozen_string_literal: true

require 'test_helper'

class PostingsResourceTest < Minitest::Test
  COMPANY_API = 'v1/companies'

  def test_list
    company_id = 'Acme'
    stub = stub_request("#{COMPANY_API}/#{company_id}/postings",
                        response: stub_response(fixture: 'postings/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    postings = client.postings.list(company_id: company_id)

    assert_equal SmartRecruiters::Collection, postings.class
    assert_equal SmartRecruiters::Posting, postings.content.first.class
    assert_equal true, postings.content.first.location['remote']
  end

  def test_list_departments
    company_id = 'Acme'
    stub = stub_request("#{COMPANY_API}/#{company_id}/departments",
                        response: stub_response(fixture: 'postings/list_departments'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    departments = client.postings.list_departments(company_id: company_id)

    assert_equal SmartRecruiters::Collection, departments.class
    assert_equal SmartRecruiters::Department, departments.content.first.class
    assert_equal 'Product', departments.content.first.label
  end

  def test_retrieve_posting
    company_id = 'Acme'
    posting_id = '0905435c-e71c-4a75-be23-3e79c68f4260'
    stub = stub_request("#{COMPANY_API}/#{company_id}/postings/#{posting_id}",
                        response: stub_response(fixture: 'postings/retrieve_posting'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    posting = client.postings.retrieve_posting(company_id: company_id, posting_id: posting_id)

    assert_equal SmartRecruiters::Posting, posting.class
    assert_equal true, posting.location['remote']
  end

  def test_create_candidate
    posting_id = '0905435c-e71c-4a75-be23-3e79c68f4260'
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
    stub = stub_request("postings/#{posting_id}/candidates",
                        method: :post, body: body, response: stub_response(fixture: 'postings/create_candidate'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    candidate = client.postings.create_candidate(posting_id: posting_id, **body)
    assert_equal SmartRecruiters::Object, candidate.class
    assert_equal '14b68c0a-de64-4638-b6d7-189a126a0891', candidate.id
  end

  def test_retrieve_candidate_status
    posting_id = '0905435c-e71c-4a75-be23-3e79c68f4260'
    candidate_id = '14b68c0a-de64-4638-b6d7-189a126a0891'

    stub = stub_request("postings/#{posting_id}/candidates/#{candidate_id}/status",
                        response: stub_response(fixture: 'postings/retrieve_candidate_status'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    status = client.postings.retrieve_candidate_status(posting_id: posting_id, candidate_id: candidate_id)

    assert_equal SmartRecruiters::Object, status.class
    assert_equal 'NEW', status.status
  end

  def test_retrieve_configuration
    posting_id = '0905435c-e71c-4a75-be23-3e79c68f4260'

    stub = stub_request("postings/#{posting_id}/configuration",
                        response: stub_response(fixture: 'postings/retrieve_configuration'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    configuration = client.postings.retrieve_configuration(posting_id: posting_id)

    assert_equal SmartRecruiters::Object, configuration.class
    assert_equal true, configuration.settings.avatarUploadAvailable
  end
end
