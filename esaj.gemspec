
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "esaj/version"

Gem::Specification.new do |spec|
  spec.name          = "esaj"
  spec.version       = Esaj::VERSION
  spec.authors       = ["Alberto Rocha"]
  spec.email         = ["betogrun@gmail.com"]

  spec.summary       = %q{Query lawsuit data from São Paulo Court of Justice.}
  spec.description   = %q{This scraper wraps the lawsuits querying services provided to the general public by the 'Sistema de Automação da Justiça' website. }
  spec.homepage      = "https://github.com/betogrun/esaj"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end
