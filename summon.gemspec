# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{summon}
  s.version = "1.1.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Charles Lowell"]
  s.date = %q{2010-03-08}
  s.description = %q{Ruby language bindings for Serials Solutions Summon Unified Discovery Service}
  s.email = ["cowboyd@thefrontside.net"]
  s.executables = ["summon", "summonh"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "bin/summon", "bin/summonh", "ispec/integration_spec.rb", "lib/summon.rb", "lib/summon/cli.rb", "lib/summon/locales/en.rb", "lib/summon/locales/fr.rb", "lib/summon/locales/jp.rb", "lib/summon/locales/dadk.rb", "lib/summon/locales/dede.rb", "lib/summon/locales/eses.rb", "lib/summon/locales/fifi.rb", "lib/summon/locales/frfr.rb", "lib/summon/locales/isis.rb", "lib/summon/locales/itit.rb", "lib/summon/locales/nlnl.rb", "lib/summon/locales/nono.rb", "lib/summon/locales/ptpt.rb", "lib/summon/locales/svse.rb", "lib/summon/locales/zacn.rb", "lib/summon/locales/zhcn.rb", "lib/summon/log.rb", "lib/summon/schema.rb", "lib/summon/schema/availability.rb", "lib/summon/schema/citation.rb", "lib/summon/schema/date.rb", "lib/summon/schema/document.rb", "lib/summon/schema/error.rb", "lib/summon/schema/facet.rb", "lib/summon/schema/query.rb", "lib/summon/schema/range.rb", "lib/summon/schema/recommendation_list.rb", "lib/summon/schema/search.rb", "lib/summon/schema/suggestion.rb", "lib/summon/service.rb", "lib/summon/transport.rb", "lib/summon/transport/canned.json", "lib/summon/transport/canned.rb", "lib/summon/transport/errors.rb", "lib/summon/transport/headers.rb", "lib/summon/transport/http.rb", "lib/summon/transport/qstring.rb", "script/console", "script/destroy", "script/generate", "spec/spec.opts", "spec/spec_helper.rb", "spec/summon/log_spec.rb", "spec/summon/schema/availability_spec.rb", "spec/summon/schema/citation_spec.rb", "spec/summon/schema/date_spec.rb", "spec/summon/schema/document_spec.rb", "spec/summon/schema/facet_spec.rb", "spec/summon/schema/query_spec.rb", "spec/summon/schema/range_spec.rb", "spec/summon/schema/recommendation_list_spec.rb", "spec/summon/schema/search_spec.rb", "spec/summon/schema_spec.rb", "spec/summon/service_spec.rb", "spec/summon/transport/headers_spec.rb", "spec/summon/transport/http_spec.rb", "spec/summon/transport/qstring_spec.rb", "spec/summon_spec.rb", "summon.gemspec"]
  s.homepage = %q{http://summon.rubyforge.org}
  s.post_install_message = %q{
For comprehensive documentation on Summon API options and usage visit:

http://api.summon.serialssolutions.com

}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{summon}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Ruby language bindings for Serials Solutions Summon Unified Discovery Service}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 1.2.0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<hoe>, [">= 2.5.0"])
    else
      s.add_dependency(%q<json>, [">= 1.2.0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<hoe>, [">= 2.5.0"])
    end
  else
    s.add_dependency(%q<json>, [">= 1.2.0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<hoe>, [">= 2.5.0"])
  end
end
