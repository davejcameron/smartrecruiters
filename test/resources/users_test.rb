# frozen_string_literal: true

require 'test_helper'

class UsersResourceTest < Minitest::Test
  USER_API = 'user-api/v201804/users'
  def test_list
    stub = stub_request(USER_API.to_s, response: stub_response(fixture: 'users/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    users = client.users.list

    assert_equal SmartRecruiters::Collection, users.class
    assert_equal SmartRecruiters::User, users.content.first.class
    assert_equal 1, users.content.length
  end

  def test_create
    body = {
      email: 'user@example.com', firstName: 'string', lastName: 'string',
      systemRole: { id: 'string', name: 'string' },
      externalData: 'string', ssoIdentifier: 'string', ssoLoginMode: 'SSO',
      language: { code: 'bg' }, password: 'string',
      location: { countryCode: 'string', regionCode: 'string', city: 'string', address: 'string', postalCode: 'string' }
    }

    stub = stub_request(USER_API.to_s,
                        method: :post, body: body,
                        response: stub_response(fixture: 'users/create', status: 201))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    user = client.users.create(**body)

    assert_equal SmartRecruiters::User, user.class
    assert_equal 'create@example.com', user.email
  end

  def test_retrieve
    user_id = 'e8c0deb2-5fff-477d-98ab-80d0dd92dbc9'
    stub = stub_request("#{USER_API}/#{user_id}",
                        response: stub_response(fixture: 'users/retrieve'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    user = client.users.retrieve(user_id: user_id)

    assert_equal SmartRecruiters::User, user.class
    assert_equal 'retrieve@example.com', user.email
  end

  def test_update
    user_id = 'e8c0deb2-5fff-477d-98ab-80d0dd92dbc9'
    body = [
      {
        op: 'replace',
        path: '/firstName',
        value: 'firstNameValue'
      },
      {
        op: 'add',
        path: '/ssoIdentifier',
        value: 'ssoIdentifierValue'
      }
    ]
    stub = stub_request("#{USER_API}/#{user_id}",
                        method: :patch, body: body,
                        response: stub_response(fixture: 'users/update'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    user = client.users.update(user_id: user_id, changes: body)

    assert_equal SmartRecruiters::User, user.class
    assert_equal 'update@example.com', user.email
  end

  def test_activate
    user_id = 'e8c0deb2-5fff-477d-98ab-80d0dd92dbc9'
    stub = stub_request("#{USER_API}/#{user_id}/activation",
                        method: :put,
                        response: stub_response(fixture: 'users/activate', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.users.activate(user_id: user_id)
  end

  def test_activation_email
    user_id = 'e8c0deb2-5fff-477d-98ab-80d0dd92dbc9'
    stub = stub_request("#{USER_API}/#{user_id}/activation-email",
                        method: :post,
                        response: stub_response(fixture: 'users/activation_email', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.users.activation_email(user_id: user_id)
  end

  def test_deactivate
    user_id = 'e8c0deb2-5fff-477d-98ab-80d0dd92dbc9'
    stub = stub_request("#{USER_API}/#{user_id}/activation",
                        method: :delete,
                        response: stub_response(fixture: 'users/deactivate', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.users.deactivate(user_id: user_id)
  end
end
