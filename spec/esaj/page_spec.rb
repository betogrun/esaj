require 'spec_helper'

RSpec.describe Esaj::Page do
  subject { described_class.new('http://some.url.com') }
  let(:document) { double(:document) }

  before do
    allow(subject).to(
      receive(:open).with('http://some.url.com', ssl_verify_mode: ::OpenSSL::SSL::VERIFY_NONE)
    )
    allow(Nokogiri::HTML::Document).to receive(:parse).and_return(document)
  end

  describe '#data' do
    it do
      expect(document).to receive(:css).with('a.linkProcesso').and_return('data')
      expect(subject.data).to eq('data')
    end
  end

  describe '#last_page?' do
    before do
      expect(document).to(
        receive(:at).with('a:contains(">>")').and_return(last_page_link)
      )
    end
    context 'true' do
      let(:last_page_link) { nil }
      it { expect(subject.last_page?).to eq(true) }
    end

    context 'false' do
      let(:last_page_link) { 'last_page_link' }
      it { expect(subject.last_page?).to eq(false) }
    end
  end
end
