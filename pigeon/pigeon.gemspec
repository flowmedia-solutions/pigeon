# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pigeon/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nick Malyon"]
  gem.email         = ["nick.malyon@gmail.com"]
  gem.description   = %q{TODO: Gooooood evening Madaaaame.  There appears to be a pigeon in your bank account.}
  gem.summary       = %q{TODO: This is a simple gem for integrating with the SagePay direct API.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "pigeon"
  gem.require_paths = ["lib"]
  gem.version       = Pigeon::VERSION
end
