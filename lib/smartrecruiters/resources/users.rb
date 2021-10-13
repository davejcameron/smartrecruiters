# frozen_string_literal: true

module SmartRecruiters
  class UsersResource < Resource
    USER_API = 'user-api/v201804'

    def list(**params)
      Collection.from_response get_request("#{USER_API}/users", params: params), type: User
    end

    def create(**attributes)
      User.new post_request("#{USER_API}/users", body: attributes).body
    end

    def retrieve(user_id:)
      User.new get_request("#{USER_API}/users/#{user_id}").body
    end

    def update(user_id:, changes:)
      User.new patch_request("#{USER_API}/users/#{user_id}", body: changes).body
    end

    def activate(user_id:, **attributes)
      put_request("#{USER_API}/users/#{user_id}/activation", body: attributes)
    end

    def activation_email(user_id:, **attributes)
      post_request("#{USER_API}/users/#{user_id}/activation-email", body: attributes)
    end

    def deactivate(user_id:)
      delete_request("#{USER_API}/users/#{user_id}/activation")
    end
  end
end
