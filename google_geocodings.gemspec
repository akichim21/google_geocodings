# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "google_geocodings/version"

Gem::Specification.new do |spec|
  spec.name          = "google_geocodings"
  spec.version       = GoogleGeocodings::VERSION
  spec.authors       = ["akichim21"]
  spec.email         = ["afujiwara2012@gmail.com"]

  spec.summary       = %q{google geocodings api wrapper}
  spec.description   = %q{google geocodings api wrapper}
  spec.homepage      = "https://github.com/akichim21/google_geocodings"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency             'httparty', '>= 0.13.1'
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.6.0"
  spec.add_development_dependency "webmock", "~> 3.0"
end
