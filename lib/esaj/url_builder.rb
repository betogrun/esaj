require_relative 'forum'

module Esaj
  class UrlBuilder
    attr_reader :oab_code, :forum, :page_number

    def initialize(oab_code, forum, page_number)
      @oab_code = oab_code
      @forum = forum
      @page_number = page_number
    end

    def build
      "#{base_url}" +
      "?paginaConsulta=#{page_number}" +
      "?dadosConsulta.localPesquisa.cdLocal=#{forum_code}" +
      "&cbPesquisa=NUMOAB" +
      "&dadosConsulta.tipoNuProcesso=UNIFICADO" +
      "&dadosConsulta.valorConsulta=#{oab_code}"
    end

    private

    def base_url
      "https://esaj.tjsp.jus.br/cpopg/trocarPagina.do"
    end

    def forum_code
      Forum.code_for(forum)
    end
  end
end
