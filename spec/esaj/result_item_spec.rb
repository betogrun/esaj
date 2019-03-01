RSpec.describe Esaj::ResultItem do
  subject { described_class.new(element) }

  let(:element) { element_for('result_item_fragment') }

  describe '#attributes' do
    it do
      expect(subject.attributes).to eq(
        {
          code: "0418538-39.1999.8.26.0053",
          details_resource: "https://esaj.tjsp.jus.br/cpopg/show.do?processo.codigo=1HZX2EH7U0000&processo.foro=53&conversationId=&dadosConsulta.localPesquisa.cdLocal=-1&cbPesquisa=NUMOAB&dadosConsulta.tipoNuProcesso=UNIFICADO&dadosConsulta.valorConsulta=111111&uuidCaptcha=&paginaConsulta=1",
          forum_code: "0053",
          forum_name: "5ª Vara de Fazenda Pública",
          category: "Ação Civil Pública Cível",
          subject: "Improbidade Administrativa",
          date: Date.parse("1999-09-03")
        }
      )
    end
  end
end
