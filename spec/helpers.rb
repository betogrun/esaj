module Helpers
  def element_for(fragment_file_name)
    fragment_for(fragment_file_name)&.children[0]
  end

  def fragment_for(file_name)
    Nokogiri::HTML::fragment(File.read("spec/fixtures/#{file_name}"))
  end
end
