# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'flickrpu/version'

Gem::Specification.new do |s|
  s.name    = %q{flickrpu}
  s.version = Flickrpu::VERSION
  s.date    = %q{2012-03-06}

  s.summary     = %q{Make S3 objects from Flickr photos.}
  s.description = %q{Make S3 objects from Flickr photos. N.B. S3 not included.}
  s.homepage    = %q{http://github.com/poeks/flickrpu}

  s.authors = ["Jen Oslislo"]
  s.email   = %q{twitterpoeks@gmail.com}

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test/*`.split("\n")

  s.require_paths     = ["lib"]

  s.rubygems_version  = %q{1.4.2}

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<flickr_fu>,      ["~> 0.3.1"])
      s.add_runtime_dependency(%q<extlib>,  ["~> 0.9.15"])
    else
      s.add_dependency(%q<flickr_fu>,      ["~> 0.3.1"])
      s.add_dependency(%q<extlib>,  ["~> 0.9.15"])
    end
  else
    s.add_dependency(%q<flickr_fu>,      ["~> 0.3.1"])
    s.add_dependency(%q<extlib>,  ["~> 0.9.15"])
  end
end