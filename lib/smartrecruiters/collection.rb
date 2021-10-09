# frozen_string_literal: true

module SmartRecruiters
  class Collection
    attr_reader :content, :limit, :offset, :next_page_id, :total_found

    def self.from_response(response, type:)
      body = response.body
      new(
        content: body['content'].map { |attrs| type.new(attrs) },
        limit: body['limit'],
        offset: body['offset'],
        next_page_id: body['nextPageId'],
        total_found: body['totalFound']
      )
    end

    def initialize(content:, limit:, offset:, next_page_id:, total_found:)
      @content = content
      @limit = limit
      @offset = offset
      @next_page_id = next_page_id
      @total_found = total_found
    end
  end
end
