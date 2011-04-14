# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nostos-source-illiad/version"

Gem::Specification.new do |s|
  s.name        = "nostos-source-illiad"
  s.version     = Source::Illiad::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brice Stacey"]
  s.email       = ["bricestacey@gmail.com"]
  s.homepage    = "https://github.com/bricestacey/nostos-source-illiad"
  s.summary     = %q{Nostos Source Driver for Illiad}
  s.description = %q{Nostos Source Driver for Illiad}

  s.rubyforge_project = "nostos-source-illiad"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency('activerecord-illiad-adapter')
  s.add_dependency('mechanize')
end
