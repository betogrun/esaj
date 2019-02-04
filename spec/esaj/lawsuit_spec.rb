RSpec.describe Esaj::Lawsuit do
  subject { described_class.new(code, details_resource ) }
  let(:code) { ' code ' }
  let(:details_resource) { '/details/resource' }

  describe '#attributes' do
    it do
      expect(subject.attributes).to eq(
        {
          code: 'code',
          details_resource: 'https://esaj.tjsp.jus.br/details/resource'
        }
      )
    end
  end
end
