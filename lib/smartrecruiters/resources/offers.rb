module SmartRecruiters
  class OffersResource < Resource
    def list(**params)
      response = get_request("offers", params: params)
      Collection.from_response(response, type: Offer)
    end

    def retrieve_offers(candidate_id:, job_id:)
      response = get_request("candidates/#{candidate_id}/jobs/#{job_id}/offers")
      Collection.from_response(response. type: Offer)
    end

    def retrieve_offer(offer_id:, candidate_id:, job_id:)
      Offer.new get_request("candidates/#{candidate_id}/jobs/#{job_id}/offers/#{offer_id}")
    end
  end
end