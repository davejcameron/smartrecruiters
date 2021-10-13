# frozen_string_literal: true

require 'test_helper'

class SystemRolesTest < Minitest::Test
  def test_list
    stub = stub_request('user-api/v201804/system-roles', response: stub_response(fixture: 'system_roles/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    system_roles = client.system_roles.list

    assert_equal SmartRecruiters::Collection, system_roles.class
    assert_equal SmartRecruiters::SystemRole, system_roles.content.first.class
    assert_equal 1, system_roles.content.length
  end
end
