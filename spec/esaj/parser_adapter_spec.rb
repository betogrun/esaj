RSpec.describe Esaj::ParserAdapter do
  subject { described_class.new('http://some.url.com') }

  describe '#document' do
    it do
      expect(subject).to(
        receive(:open).with('http://some.url.com', ssl_verify_mode: ::OpenSSL::SSL::VERIFY_NONE)
      )
      expect(Nokogiri::HTML::Document).to receive(:parse).and_return('document')
      expect(subject.document).to eq('document')
    end
  end
end

