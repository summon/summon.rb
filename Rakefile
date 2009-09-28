require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/summon'

Hoe.plugin :newgem

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'summon' do
  self.developer 'Charles Lowell', 'cowboyd@thefrontside.net'
  self.post_install_message = 'PostInstall.txt'
  self.rubyforge_name       = self.name
  self.extra_deps           = [
                                ['json_pure','>= 1.1.7']
                              ]
  self.extra_dev_deps       = [
                                ['rspec', '>= 1.2.7']
                            ]                          
  self.version              = Summon::VERSION
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }
