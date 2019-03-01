require_relative 'scraper'

module Esaj
  class Query
    attr_reader :oab_code, :forum

    def initialize(oab_code:, forum:)
      @oab_code = oab_code
      @forum = forum
    end

    def perform
      begin
        scraped_results
      rescue RemoteError => error
        { error: error.message }
      end
    end

    private

    def scraped_results
      Scraper.new(oab_code, forum).results
    end
  end
end
