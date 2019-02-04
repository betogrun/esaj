require_relative 'url_builder'
require_relative 'query_page'
require_relative 'metadata'

module Esaj
  class RemoteError < StandardError; end
  class Scraper
    extend Forwardable

    def_delegators :@metadata, :total_pages, :error?, :error_message

    attr_reader :oab_code, :forum

    def initialize(oab_code, forum)
      @oab_code = oab_code
      @forum = forum
      @metadata = Metadata.new(metadata_url)
    end

    def results
      raise RemoteError.new(error_message) if error?
      query_pages.flat_map(&:result_set)
    end

    private

    def query_pages
      [].tap do |pages|
        1.upto(total_pages) do |page_number|
          url = url_for(page_number)
          pages << QueryPage.new(url)
        end
      end
    end

    def metadata_url
      url_for(1)
    end

    def url_for(page_number)
      UrlBuilder.new(oab_code, forum, page_number).build
    end
  end
end
