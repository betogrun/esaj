RSpec.describe Esaj::UrlBuilder do
  subject { described_class.new(oab_code, forum, page_number) }
  let(:oab_code) { '111111' }
  let(:forum) { :all }
  let(:page_number) { 1 }

  describe '#build' do
    it do
      expect(subject.build).to(
        eq(
          "https://esaj.tjsp.jus.br/cpopg/trocarPagina.do" +
          "?paginaConsulta=1?" +
          "dadosConsulta.localPesquisa.cdLocal=-1" +
          "&cbPesquisa=NUMOAB" +
          "&dadosConsulta.tipoNuProcesso=UNIFICADO" +
          "&dadosConsulta.valorConsulta=111111"
        )
      )
    end
  end
end
