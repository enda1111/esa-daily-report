# frozen_string_literal: true

require 'slack-notifier'

class Notify
  COLOR_CODE = {
    ok: 'good',
    warning: 'danger'
  }.freeze

  def initialize(webhook_url:, channel:)
    @webhook_url = webhook_url
    @channel = channel
  end

  def call(message, title, link, status)
    notifier.post(
      attachments: [{
        text: message,
        title: title,
        title_link: link,
        color: color_code(status)
      }],
      channel: channel
    )
  end

  private

  attr_reader :webhook_url, :channel

  def color_code(status)
    COLOR_CODE[status] || '#00FF00'
  end

  def notifier
    @notifier ||= Slack::Notifier.new(webhook_url)
  end
end
