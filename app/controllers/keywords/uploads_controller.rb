# frozen_string_literal: true

module Keywords
  class UploadsController < ApplicationController
    def show; end

    def update
      new_words = extract_words_form_upload_file
      keywords = create_new_keywords(new_words)
      keywords.each do |keyword|
        scrape(keyword)
      end

      redirect_to keywords_path
    rescue StandardError => e
      p e
      flash[:error] = 'Something went wrong! Please try again.'
      render 'show'
    end

    private

    def uploads_params
      params.require(:uploads).permit(:file)
    end

    def extract_words_form_upload_file
      raw_file = uploads_params[:file].read.force_encoding('UTF-8')

      raw_file.split("\n").map(&:strip)
    end

    def create_new_keywords(new_words)
      current_user.user_keywords.destroy_all
      current_user.keywords.destroy_all
      keywords = []
      ActiveRecord::Base.transaction do
        new_words.each do |new_word|
          keywords << current_user.keywords.create!(word: new_word)
        end
      end

      keywords
    end

    def scrape(keyword)
      p "start scraping for #{keyword.word}"
      Puppeteer.launch(headless: false) do |browser|
        page = browser.new_page
        page.viewport = Puppeteer::Viewport.new(width: 1280, height: 800)

        page.goto('https://google.com/', wait_until: 'domcontentloaded')
        form = page.query_selector('form[action="/search"]')
        q = form.query_selector('*[name="q"]')
        p "before type #{keyword.word}"
        q.type_text(keyword.word)

        page.wait_for_navigation { page.evaluate('document.forms[0].submit()') }

        keyword.html = page.content.to_s
        data = extract_data(page)

        keyword.total_link = data[:total_link]
        keyword.total_adword = data[:total_adword]
        keyword.total_result = data[:total_result]
        keyword.total_search_time = data[:search_time]

        keyword.save
      end
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
  end
end
