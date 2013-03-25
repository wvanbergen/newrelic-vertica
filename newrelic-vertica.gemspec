# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'newrelic-vertica/version'

Gem::Specification.new do |gem|
  gem.name          = "newrelic-vertica"
  gem.version       = Newrelic::Vertica::VERSION
  gem.authors       = ["Willem van Bergen"]
  gem.email         = ["willem@railsdoctors.com"]
  gem.homepage      = "https://github.com/sprsquish/vertica"
  gem.description   = %q{Add NewRelic instrumentation to the pure Ruby Vertica driver.}
  gem.summary       = <<-D
    Adds NewRelic instrumentation to the pure ruby Vertica driver (https://github.com/sprsquish/vertica).
  D

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
