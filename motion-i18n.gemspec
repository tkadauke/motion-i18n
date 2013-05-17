# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "motion-i18n"
  s.version     = "0.0.2"
  s.authors     = ["Thomas Kadauke"]
  s.email       = ["thomas.kadauke@googlemail.com"]
  s.homepage    = "https://github.com/tkadauke/motion-i18n"
  s.summary     = "Wrapper for translations in RubyMotion"
  s.description = "Wrapper for translations in RubyMotion"

  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency 'motion-require'
  s.add_dependency 'i18n'
  s.add_development_dependency 'rake'
end
