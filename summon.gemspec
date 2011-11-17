# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "summon/version"

Gem::Specification.new do |s|
  s.name = %q{summon}
  s.version = Summon::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Charles Lowell", "Dani\303\253l van de Burgt"]
  s.description = %q{Ruby language bindings for Serials Solutions Summon Unified Discovery Service}
  s.email = ["cowboyd@thefrontside.net", "daniel.vandeburgt@serialssolutions.com"]
  s.executables = ["summon", "summonh"]
  s.homepage = "http://github.com/summon/summon.rb"
  s.post_install_message = %q{
For comprehensive documentation on Summon API options and usage visit:

http://api.summon.serialssolutions.com

}

  s.summary = %q{Ruby language bindings for Serials Solutions Summon Unified Discovery Service}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "json"

  s.add_development_dependency "rspec", "~> 2.0"
  s.add_development_dependency "rake"
end
