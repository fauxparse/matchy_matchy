lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matchy_matchy/version'

Gem::Specification.new do |spec|
  spec.name          = 'matchy_matchy'
  spec.version       = MatchyMatchy::VERSION
  spec.authors       = ['Matt Powell']
  spec.email         = ['fauxparse@gmail.com']

  spec.summary       = 'A cute Stable Match implementation'
  spec.homepage      = 'https://github.com/fauxparse/matchy_matchy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'cry', '~> 0.1'

  spec.add_development_dependency 'bundler', '~> 1.16.a'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
end
