require "test_helper"

class UsersResourceTest < Minitest::Test
  def test_list
    stub = stub_request("user-api/v201804/users", response: stub_response(fixture: "users/list"))
    client = SmartRecruiters::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    users = client.users.list

    assert_equal SmartRecruiters::Collection, users.class
    assert_equal SmartRecruiters::User, users.content.first.class
    assert_equal 1, users.content.length
  end
end