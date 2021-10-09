# frozen_string_literal: true

module SmartRecruiters
  class AccessGroupsResource < Resource
    def list
      Collection.from_response get_request('user-api/v201804/access-groups'), type: AccessGroup
    end
  end
end
