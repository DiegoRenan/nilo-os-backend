# -*- encoding: utf-8 -*-
# stub: versionist 2.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "versionist".freeze
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Brian Ploetz".freeze]
  s.date = "2019-07-22"
  s.description = "A plugin for versioning Rails based RESTful APIs.".freeze
  s.homepage = "https://github.com/bploetz/versionist".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "versionist-2.0.1".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3"])
      s.add_runtime_dependency(%q<yard>.freeze, ["~> 0.9.20"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9.20"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9.20"])
  end
end
