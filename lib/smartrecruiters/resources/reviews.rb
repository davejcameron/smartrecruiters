# frozen_string_literal: true

module SmartRecruiters
  class ReviewsResource < Resource
    def list(candidate_id:, job_id:)
      params = { candidateId: candidate_id, jobId: job_id }
      Collection.from_response get_request('reviews', params: params), type: Review
    end

    def create(**attributes)
      Review.new post_request('reviews', body: attributes).body
    end

    def retrieve(review_id:)
      Review.new get_request("reviews/#{review_id}").body
    end

    def update(review_id:, **attributes)
      patch_request("reviews/#{review_id}", body: attributes)
    end

    def delete(review_id:, reviewer_id:)
      delete_request("reviews/#{review_id}", params: { reviewerId: reviewer_id })
    end
  end
end
