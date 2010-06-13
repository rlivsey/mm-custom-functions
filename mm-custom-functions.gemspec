# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mm-custom-functions}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Livsey"]
  s.date = %q{2010-06-13}
  s.email = %q{richard@livsey.org}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["LICENSE", "log.log", "mongo-spec.log", "Rakefile", "README.rdoc", "spec", "lib/mm-custom-functions.rb"]
  s.homepage = %q{http://github.com/rlivsey/mm-custom-functions}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Easily manage custom MongoDB functions with MongoMapper}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongo_mapper>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<mongo_mapper>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<mongo_mapper>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
