# frozen_string_literal: true

class AddScrapeStatusToKeywords < ActiveRecord::Migration[7.0]
  def change
    add_column :keywords, :scrape_status, :string
  end
end
