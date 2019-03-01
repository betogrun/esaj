RSpec.describe Esaj::QueryPage do
  subject { described_class.new('http://some.url.com') }
  let(:parser_instance) { double(:parser_instance) }
  let(:document) { double(:document) }

  before do
    allow(Esaj::ParserAdapter).to(
      receive(:new).and_return(parser_instance)
    )
    allow(parser_instance).to receive(:document).and_return(document)
  end

  describe "#result_set" do
    let(:element) { double(:element) }
    let(:result_item_instance) { double(:result_item_instance) }
    let(:attributes) { double(:attributes) }

    before do
      allow(document).to(
        receive(:css).with('div[id^="divProcesso"]').and_return([element])
      )
    end

    it do
      expect(Esaj::ResultItem).to(
        receive(:new).with(element).and_return(result_item_instance)
      )
      expect(result_item_instance).to(
        receive(:attributes).and_return(attributes)
      )
      expect(subject.result_set).to eq([attributes])
    end
  end
end
