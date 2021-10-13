# frozen_string_literal: true

require 'test_helper'

class OffersResourceTest < Minitest::Test
  def test_list
    stub = stub_request('offers', response: stub_response(fixture: 'offers/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    offers = client.offers.list

    assert_equal SmartRecruiters::Collection, offers.class
    assert_equal SmartRecruiters::Offer, offers.content.first.class
    assert_equal 1, offers.content.length
  end

  def test_retrieve_offers
    candidate_id = '9909fa4b-7749-4d28-97b4-a0d835cc5062'
    job_id = 'cf62eaf4-ee86-4e07-ad6e-5409a01b1674'
    stub = stub_request("candidates/#{candidate_id}/jobs/#{job_id}/offers",
                        response: stub_response(fixture: 'offers/retrieve_offers'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    offers = client.offers.retrieve_offers(candidate_id: candidate_id, job_id: job_id)

    assert_equal SmartRecruiters::Collection, offers.class
    assert_equal SmartRecruiters::Offer, offers.content.first.class
    assert_equal 1, offers.content.length
  end

  def test_retrieve
    offer_id = '99d6ceef-6ffe-47c8-a941-58c6fb5d1e52'
    candidate_id = '9909fa4b-7749-4d28-97b4-a0d835cc5062'
    job_id = 'cf62eaf4-ee86-4e07-ad6e-5409a01b1674'
    stub = stub_request("candidates/#{candidate_id}/jobs/#{job_id}/offers/#{offer_id}",
                        response: stub_response(fixture: 'offers/retrieve'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    offer = client.offers.retrieve(offer_id: offer_id, candidate_id: candidate_id, job_id: job_id)

    assert_equal SmartRecruiters::Offer, offer.class
    assert_equal 'CREATED', offer.status
  end
end
