# frozen_string_literal: true

require 'esa'
require 'date'

class DailyReport
  class ReportNotFoundError < StandardError; end

  def initialize(username:, access_token:, team:)
    @username = username
    @access_token = access_token
    @team = team
  end

  def url
    "#{host}/posts/#{today_report_post['number']}"
  end

  def edit_url
    "#{host}/posts/#{today_report_post['number']}/edit"
  end

  def full_name
    raise ReportNotFoundError unless present?
    today_report_post['full_name']
  end

  def wip?
    raise ReportNotFoundError unless present?
    today_report_post['wip']
  end

  def present?
    !today_report_post.nil?
  end

  private

  attr_reader :username, :access_token, :team

  def host
    "https://#{team}.esa.io"
  end

  def today_report_post
    @today_report_post ||= today_report_posts.body['posts'].find { |p| p['name'].include?(username) }
  end

  def today_report_posts
    @today_report_posts ||= client.posts(q: "in:#{today_daily_reports_query}")
  end

  def client
    @client ||= Esa::Client.new(access_token: access_token, current_team: team)
  end

  def today_daily_reports_query
    Date.today.strftime('日報/%Y/%m/%d')
  end
end
