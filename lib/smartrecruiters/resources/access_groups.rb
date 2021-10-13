# frozen_string_literal: true

module SmartRecruiters
  class AccessGroupsResource < Resource
    ACCESS_GROUP_API = 'user-api/v201804/access-groups'

    def list
      Collection.from_response get_request(ACCESS_GROUP_API.to_s), type: AccessGroup
    end

    def assign_users(group_id:, user_ids:)
      Collection.from_response post_request("#{ACCESS_GROUP_API}/#{group_id}/users", body: user_ids), type: User
    end

    def remove_user(group_id:, user_id:)
      delete_request("#{ACCESS_GROUP_API}/#{group_id}/users/#{user_id}")
    end
  end
end
