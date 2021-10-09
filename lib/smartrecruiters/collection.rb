module SmartRecruiters
  class Collection
    attr_reader :content, :limit, :offset, :next_page_id, :total_found

    def self.from_response(response, type:)
      body = response.body
      new(
        content: body['content'].map { |attrs| type.new(attrs) },
        limit: body.dig('limit'),
        offset: body.dig('offset'),
        next_page_id: body.dig('nextPageId'),
        total_found: body.dig('totalFound')
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
