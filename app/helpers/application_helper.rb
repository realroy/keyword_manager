# frozen_string_literal: true

module ApplicationHelper
  def scrape_status_class(scrape_status)
    {
      Keyword.scrape_statuses[:pending] => 'text-yellow-400',
      Keyword.scrape_statuses[:success] => 'text-teal-400',
      Keyword.scrape_statuses[:failed] => 'text-red-400'
    }[scrape_status.upcase]
  end

  def scrape_status_badge_class(scrape_status)
    {
      Keyword.scrape_statuses[:pending] => 'bg-yellow-400 animate-ping',
      Keyword.scrape_statuses[:success] => 'bg-teal-400',
      Keyword.scrape_statuses[:failed] => 'bg-red-400'
    }[scrape_status.upcase]
  end
end
