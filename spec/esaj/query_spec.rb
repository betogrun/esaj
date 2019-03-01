RSpec.describe Esaj::Query do
  subject { described_class.new(oab_code: oab_code, forum: forum) }
  let(:oab_code) { '000000' }
  let(:forum) { :all }

  describe '#perform' do
    let(:scraper_instance) { double(:scraper_instance) }

    before do
      expect(Esaj::Scraper).to(
        receive(:new).and_return(scraper_instance)
      )
    end

    context 'success' do
      let(:scraped_result) { double(:scraped_result) }

      it do
        expect(scraper_instance).to(
          receive(:results).and_return([scraped_result])
        )
        expect(subject.perform).to eq([scraped_result])
      end

    end

    context 'error' do
      it do
        allow(scraper_instance).to(
          receive(:results).and_raise(Esaj::RemoteError, 'error!')
        )
        expect(subject.perform).to eq({error: 'error!'})
      end
    end
  end
end
