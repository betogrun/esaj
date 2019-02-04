RSpec.describe Esaj::Scraper do
  subject { described_class.new(oab_code, forum) }
  let(:oab_code) { double(:oab_code) }
  let(:forum) { double(:forum) }
  let(:page_number) { 1 }

  describe '#results' do
    let(:url_builder_instance) { double(:url_builder_instance) }
    let(:metadata_instance) { double(:metadata_instance) }
    let(:url) { double(:url) }

    before do
      allow(Esaj::UrlBuilder).to(
        receive(:new).with(oab_code, forum, page_number)
        .and_return(url_builder_instance)
      )
      allow(url_builder_instance).to(
        receive(:build).and_return(url)
      )
      allow(Esaj::Metadata).to(
        receive(:new).with(url).and_return(metadata_instance)
      )
    end

    context 'success' do
      let(:query_page_instance) { double(:query_page_instance) }

      it do
        expect(metadata_instance).to(
          receive(:error?).and_return(false)
        )
        expect(metadata_instance).to(
          receive(:total_pages).and_return(1)
        )
        expect(Esaj::QueryPage).to(
          receive(:new).and_return(query_page_instance)
        )
        expect(query_page_instance).to(
          receive(:result_set).and_return('result')
        )
        expect(subject.results).to eq(['result'])
      end
    end

    context 'error' do
      it do
        expect(metadata_instance).to(
          receive(:error?).and_return(true)
        )
        expect(metadata_instance).to(
          receive(:error_message).and_return('error!')
        )
        expect{ subject.results }.to(
          raise_error(Esaj::RemoteError, 'error!')
        )
      end
    end
  end
end
