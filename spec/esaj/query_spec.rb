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
      let(:lawsuit_instance) { double(:lawsuit_instance) }
      let(:lawsuit_attributes) { double(:lawsuit_attributes) }

      it do
        expect(scraper_instance).to(
          receive(:results).and_return([scraped_result])
        )
        expect(Esaj::Lawsuit).to(
          receive(:new).and_return(lawsuit_instance)
        )
        expect(lawsuit_instance).to(
          receive(:attributes).and_return(lawsuit_attributes)
        )
        expect(subject.perform).to eq([lawsuit_attributes])
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
