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
    let(:result_element) do
      double(:result_element, text: 'code', :[] => 'resource')
    end

    before do
      allow(document).to(
        receive(:css).with('a.linkProcesso').and_return([result_element])
      )
    end

    it do
      expect(subject.result_set).to(
        eq(
          [
            {
              lawsuit_code: 'code',
              lawsuit_details_resource: 'resource'
            }
          ]
        )
      )
    end

  end
end
