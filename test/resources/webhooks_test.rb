# frozen_string_literal: true

require 'test_helper'

class WebhooksResourceTest < Minitest::Test
  WEBHOOK_API = 'webhooks-api/v201907/subscriptions'
  def test_list
    stub = stub_request(WEBHOOK_API.to_s, response: stub_response(fixture: 'webhooks/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    webhooks = client.webhooks.list

    assert_equal SmartRecruiters::Collection, webhooks.class
    assert_equal SmartRecruiters::Webhook, webhooks.content.first.class
    assert_equal 2, webhooks.content.length
  end

  def test_retrieve
    webhook_id = '643ba46a-a2ef-4e7f-aeab-f51b90eed368'
    stub = stub_request("#{WEBHOOK_API}/#{webhook_id}",
                        response: stub_response(fixture: 'webhooks/retrieve'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    webhook = client.webhooks.retrieve(webhook_id: webhook_id)

    assert_equal SmartRecruiters::Webhook, webhook.class
    assert_equal 'active', webhook.status
  end

  def test_create
    body = {
      callbackUrl: 'https://server.com/send/callback/here', events: ['job.created'],
      alertingEmailAddress: 'webhook.alerts@domain.com',
      callbackAuthentication: {
        type: 'header',
        headerName: 'X-TOKEN',
        headerValue: 'J?7HSgUKm7!MPm+EKm^P4BwW4ywRRRVu'
      }
    }
    stub = stub_request(WEBHOOK_API.to_s,
                        method: :post, body: body,
                        response: stub_response(fixture: 'webhooks/create', status: 201))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    webhook = client.webhooks.create(**body)

    assert_equal SmartRecruiters::Webhook, webhook.class
    assert_equal 'job.created', webhook.events.first['name']
  end

  def test_delete
    webhook_id = '643ba46a-a2ef-4e7f-aeab-f51b90eed368'
    stub = stub_request("#{WEBHOOK_API}/#{webhook_id}",
                        method: :delete,
                        response: stub_response(fixture: 'webhooks/delete', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.webhooks.delete(webhook_id: webhook_id)
  end

  def test_activate
    webhook_id = '643ba46a-a2ef-4e7f-aeab-f51b90eed368'
    stub = stub_request("#{WEBHOOK_API}/#{webhook_id}/activation",
                        method: :put,
                        response: stub_response(fixture: 'webhooks/activate', status: 204))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    assert client.webhooks.activate(webhook_id: webhook_id)
  end

  def test_callbacks_log
    webhook_id = '643ba46a-a2ef-4e7f-aeab-f51b90eed368'
    stub = stub_request("#{WEBHOOK_API}/#{webhook_id}/callbacks-log",
                        response: stub_response(fixture: 'webhooks/callbacks_log'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    logs = client.webhooks.callbacks_log(webhook_id: webhook_id)

    assert_equal SmartRecruiters::Collection, logs.class
    assert_equal SmartRecruiters::CallbacksLog, logs.content.first.class
    assert_equal 'successful', logs.content.first.status
  end

  def test_generate_secret
    webhook_id = '643ba46a-a2ef-4e7f-aeab-f51b90eed368'
    stub = stub_request("#{WEBHOOK_API}/#{webhook_id}/secret-key",
                        method: :post,
                        response: stub_response(fixture: 'webhooks/generate_secret', status: 201))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    secret = client.webhooks.generate_secret(webhook_id: webhook_id)

    assert_equal 'HeBVky2bccvvkcXPimH8c', secret.secretKey
  end

  def test_retrieve_secret
    webhook_id = '643ba46a-a2ef-4e7f-aeab-f51b90eed368'
    stub = stub_request("#{WEBHOOK_API}/#{webhook_id}/secret-key",
                        response: stub_response(fixture: 'webhooks/retrieve_secret'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    secret = client.webhooks.retrieve_secret(webhook_id: webhook_id)

    assert_equal SmartRecruiters::Object, secret.class
    assert_equal '7014ac1c2ab4ba0633f5a113ac323f8bc9ec4fd5515683990178a0570e695721', secret.secretKey
  end
end
