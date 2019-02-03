RSpec.describe Esaj::Metadata do
  subject { described_class.new('http://some.url.com') }
  let(:parser_instance) { double(:parser_instance) }
  let(:document) { double(:document) }

  before do
    allow(Esaj::ParserAdapter).to(
      receive(:new).and_return(parser_instance)
    )
    allow(parser_instance).to receive(:document).and_return(document)
  end

  describe '#total_pages' do
    let(:pagination_element) { double(:pagination_element) }
    let(:formatted_pagination_result) { ["Resultados", "1", "a", "25", "de", "64"] }

    before do
      allow(document).to(
        receive(:css).with('span.resultadoPaginacao')
        .and_return(pagination_element)
      )
      allow(pagination_element).to(
        receive_message_chain(:text, :split, :uniq)
        .and_return(formatted_pagination_result)
      )
    end

    it { expect(subject.total_pages).to eq(3) }
  end

  describe 'error methods' do
    let(:error_message_element) { double(:error_message_element) }
    let(:formatted_error_message) { 'Error message' }

    before do
      allow(document).to(
        receive(:css).with('td#mensagemRetorno')
        .and_return(error_message_element)
      )
      allow(error_message_element).to(
        receive_message_chain(:text, :strip)
        .and_return(formatted_error_message)
      )
    end

    describe '#error_message' do
      it { expect(subject.error_message).to eq('Error message') }
    end

    describe '#error?' do
      context 'true' do
        it { expect(subject.error?).to eq(true) }
      end

      context 'false' do
        let(:formatted_error_message) { '' }
        it { expect(subject.error?).to eq(false) }
      end
    end
  end
end
