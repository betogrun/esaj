module Esaj
  class ResultItem
    attr_reader :element

    def initialize(element)
      @element = element.children[1]
    end

    def attributes
      {
        code: code,
        details_resource: details_resource,
        forum_code: forum_code,
        forum_name: forum_name,
        category: category,
        subject: subject,
        date: date
      }
    end

    private

    def code
      element_link.text.strip
    end

    def details_resource
      "https://esaj.tjsp.jus.br#{element_link['href']}"
    end

    def element_link
      element.at_css('a')
    end

    def forum_code
      code[-4..-1]
    end

    def forum_name
      receipt_data.last
    end

    def category
      striped_text = element.children[2].text.strip
      striped_text[0, striped_text.size-1]
    end

    def subject
      striped_text = element.children[4].text.strip
      striped_text[1, striped_text.size]
    end

    def date
      Date.parse(receipt_data.first[-10..-1])
    end

    def receipt_data
      element.children[children_count-2].text.split(' - ').map(&:strip)
    end

    def children_count
      element.children.count
    end
  end
end
