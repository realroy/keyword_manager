# frozen_string_literal: true

class BackfillingDefaultKeywordScrapeStatuses < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def up
    Keyword.unscoped.in_batches do |relation|
      relation.update_all scrape_status: 'SUCCESS'
      sleep(0.01) # throttle
    end
  end
end
