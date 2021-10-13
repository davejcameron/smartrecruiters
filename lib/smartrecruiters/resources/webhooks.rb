# frozen_string_literal: true

module SmartRecruiters
  class WebhooksResource < Resource
    WEBHOOK_API = 'webhooks-api/v201907'

    def list(**params)
      response = get_request("#{WEBHOOK_API}/subscriptions", params: params)
      Collection.from_response(response, type: Webhook)
    end

    def create(**attributes)
      Webhook.new post_request("#{WEBHOOK_API}/subscriptions", body: attributes).body
    end

    def retrieve(webhook_id:)
      Webhook.new get_request("#{WEBHOOK_API}/subscriptions/#{webhook_id}").body
    end

    def delete(webhook_id:)
      delete_request("#{WEBHOOK_API}/subscriptions/#{webhook_id}")
    end

    def activate(webhook_id:, **attributes)
      put_request("#{WEBHOOK_API}/subscriptions/#{webhook_id}/activation", body: attributes)
    end

    def callbacks_log(webhook_id:, **params)
      response = get_request("#{WEBHOOK_API}/subscriptions/#{webhook_id}/callbacks-log", params: params)
      Collection.from_response(response, type: CallbacksLog)
    end

    def generate_secret(webhook_id:, **attributes)
      Object.new post_request("#{WEBHOOK_API}/subscriptions/#{webhook_id}/secret-key", body: attributes).body
    end

    def retrieve_secret(webhook_id:)
      Object.new get_request("#{WEBHOOK_API}/subscriptions/#{webhook_id}/secret-key").body
    end
  end
end
