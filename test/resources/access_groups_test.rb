# frozen_string_literal: true

require 'test_helper'

class AccessGroupsResourceTest < Minitest::Test
  ACCESS_GROUP_API = 'user-api/v201804/access-groups'

  def test_list
    stub = stub_request(ACCESS_GROUP_API.to_s, response: stub_response(fixture: 'access_groups/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    groups = client.access_groups.list

    assert_equal SmartRecruiters::Collection, groups.class
    assert_equal SmartRecruiters::AccessGroup, groups.content.first.class
    assert_equal 1, groups.content.length
  end

  def test_assign_users
    group_id = '60497fe33e2b74a609b7e410'
    user_ids = ['b4442b1b-973a-4562-9bbe-221defc23cf1']
    stub = stub_request("#{ACCESS_GROUP_API}/#{group_id}/users",
                        method: :post, body: user_ids,
                        response: stub_response(fixture: 'access_groups/assign_users', status: 201))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    users = client.access_groups.assign_users(group_id: group_id, user_ids: user_ids)

    assert_equal SmartRecruiters::Collection, users.class
    assert_equal SmartRecruiters::User, users.content.first.class
  end

  def test_remove_user
    group_id = '60497fe33e2b74a609b7e410'
    user_id = 'b4442b1b-973a-4562-9bbe-221defc23cf1'
    stub = stub_request("#{ACCESS_GROUP_API}/#{group_id}/users/#{user_id}",
                        method: :delete,
                        response: stub_response(fixture: 'access_groups/remove_user', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.access_groups.remove_user(group_id: group_id, user_id: user_id)
  end
end
