# frozen_string_literal: true

require_relative './initialize'
require_relative './daily_report'
require_relative './notify'

daily_report = DailyReport.new(username: ENV['USER_NAME'], access_token: ENV['ESA_ACCESS_TOKEN'], team: ENV['ESA_TEAM'])

return unless daily_report.present?

if daily_report.wip?
  status = :warning
  message = 'そろそろ日報を書こう！'
  link = daily_report.edit_url
else
  status = :ok
  message = '日報完了してます :+1: お疲れさまでした。'
  link = daily_report.url
end

Notify.new(webhook_url: ENV['SLACK_WEBHOOK_URL'], channel: ENV['SLACK_CHANNEL'])
  .call(message, daily_report.full_name, link, status)
