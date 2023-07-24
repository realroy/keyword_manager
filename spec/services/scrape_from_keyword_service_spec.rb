require 'rails_helper'

RSpec.describe ScrapeFromKeywordService do
  context 'when success' do
    let(:keyword) { create(:keyword) }

    it 'should update keyword scrape_status to success' do
      described_class.new(keyword:).call
      keyword.reload

      expect(keyword.scrape_status).to eq('success')
    end
  end

  context 'when failed' do
    let(:keyword) { create(:keyword) }

    before do
      allow_any_instance_of(Puppeteer::Page).to receive(:evaluate).and_raise(StandardError)
    end

    it 'should update keyword scrape_status to success' do
      described_class.new(keyword:).call
      keyword.reload

      expect(keyword.scrape_status).to eq('failed')
    end
  end
end
