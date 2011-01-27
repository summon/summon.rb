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
  self.developer 'Daniël van de Burgt', 'daniel.vandeburgt@serialssolutions.com'
  self.post_install_message = File.read('PostInstall.txt')
  self.rubyforge_name       = self.name
  self.extra_deps           = [
                                ['json','>= 1.2.0']
                              ]
  self.extra_dev_deps       = [
                                ['rspec', '>= 1.2.9'],
                                ['newgem']
                            ]                          
  self.version              = Summon::VERSION
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }
