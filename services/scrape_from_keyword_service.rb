# frozen_string_literal: true

class ScrapeFromKeywordService
  def initialize(keyword:)
    @keyword = keyword
  end

  def call
    Puppeteer.launch(headless: true) do |browser|
      page = browser.new_page
      page.viewport = Puppeteer::Viewport.new(width: 1280, height: 800)

      fill_form_then_search(page)
      save_content(page)
      save_keyword(extract_data(page))
    rescue StandardError => e
      Rails.logger.error e
      @keyword.scrape_status_failed!
    end
  end

  private

  def fill_form_then_search(page)
    page.goto('https://google.com/', wait_until: 'domcontentloaded')

    form = page.query_selector('form[action="/search"]')
    form.query_selector('*[name="q"]').type_text(@keyword.word)

    page.wait_for_navigation { page.evaluate('document.forms[0].submit()') }

    page
  end

  def extract_data(page)
    raw_search_result = page.query_selector('#result-stats')
                            .evaluate("node => node.innerText.replace('(', '').replace(')', '')")
    search_result_match_data = raw_search_result.match(/\S+\s(?<total_result>\S+)\s\S+\s(?<search_time>\S+)\s/)

    {
      total_link: page.evaluate("() => [...document.querySelectorAll('a')].filter(a => !!a.querySelector('h3')).length"),
      total_adword: page.evaluate("() => document.querySelectorAll('*[data-text-ad]').length"),
      total_result: search_result_match_data[:total_result].gsub(',', '').to_i,
      search_time: search_result_match_data[:search_time].to_f
    }
  end

  def save_content(page)
    @keyword.html = page.content.to_s
    @keyword.save
  end

  def save_keyword(data)
    Rails.logger.debug data

    @keyword.total_link = data[:total_link]
    @keyword.total_adword = data[:total_adword]
    @keyword.total_result = data[:total_result]
    @keyword.total_search_time = data[:search_time]
    @keyword.scrape_status = Keyword.scrape_statuses[:success]

    @keyword.save!
  end
end
