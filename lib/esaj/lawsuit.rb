module Esaj
  class Lawsuit
    attr_reader :code, :details_resource

    def initialize(code, details_resource)
      @code = code
      @details_resource = details_resource
    end

    def attributes
      {
        code: formatted_code,
        details_resource: formatted_details_resource
      }
    end

    private

    def formatted_code
      code.strip
    end

    def formatted_details_resource
      "https://esaj.tjsp.jus.br#{details_resource}"
    end
  end
end
