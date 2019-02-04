require_relative 'scraper'
require_relative 'lawsuit'

module Esaj
  class Query
    attr_reader :oab_code, :forum

    def initialize(oab_code:, forum:)
      @oab_code = oab_code
      @forum = forum
    end

    def perform
      begin
        lawsuits.map(&:attributes)
      rescue RemoteError => error
        { error: error.message }
      end
    end

    private

    def lawsuits
      scraped_results.map do |attributes|
        Lawsuit.new(attributes)
      end
    end

    def scraped_results
      Scraper.new(oab_code, forum).results
    end
  end
end
