# frozen_string_literal: true

require 'test_helper'

class ReviewsResourceTest < Minitest::Test
  def test_list
    candidate_id = '50da5f6e-f8d3-4475-ab01-82a5aadee9b2'
    job_id = '211ef34c-3bf6-40b9-a3eb-a38b6fde2253'
    stub = stub_request("reviews?candidateId=#{candidate_id}&jobId=#{job_id}",
                        response: stub_response(fixture: 'reviews/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    reviews = client.reviews.list(candidate_id: candidate_id, job_id: job_id)

    assert_equal SmartRecruiters::Collection, reviews.class
    assert_equal SmartRecruiters::Review, reviews.content.first.class
  end

  def test_create
    body = {
      reviewerId: '69102220-00e1-4672-a202-890825b79645',
      candidateId: '50da5f6e-f8d3-4475-ab01-82a5aadee9b2',
      jobId: '211ef34c-3bf6-40b9-a3eb-a38b6fde2253',
      overallRating: 0,
      comment: 'Create',
      createdOn: '2021-10-13T18:41:01.833Z'
    }
    stub = stub_request('reviews',
                        method: :post, body: body,
                        response: stub_response(fixture: 'reviews/create', status: 201))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    review = client.reviews.create(**body)

    assert_equal SmartRecruiters::Review, review.class
    assert_equal 'Create', review.comment
  end

  def test_retrieve
    review_id = '0837e9b7-c037-4708-8437-8f714f5c8a05'
    stub = stub_request("reviews/#{review_id}",
                        response: stub_response(fixture: 'reviews/retrieve'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    review = client.reviews.retrieve(review_id: review_id)

    assert_equal SmartRecruiters::Review, review.class
    assert_equal 'Great review', review.comment
  end

  def test_update
    review_id = '0837e9b7-c037-4708-8437-8f714f5c8a05'
    body = {
      overallRating: 0,
      comment: 'string',
      reviewerId: 'string'
    }
    stub = stub_request("reviews/#{review_id}",
                        method: :patch,
                        body: body,
                        response: stub_response(fixture: 'reviews/update', status: 201))

    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.reviews.update(review_id: review_id, **body)
  end

  def test_delete
    review_id = '0837e9b7-c037-4708-8437-8f714f5c8a05'
    reviewer_id = '69102220-00e1-4672-a202-890825b79645'
    stub = stub_request("reviews/#{review_id}?reviewerId=#{reviewer_id}",
                        method: :delete,
                        response: stub_response(fixture: 'reviews/delete', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.reviews.delete(review_id: review_id, reviewer_id: reviewer_id)
  end
end
