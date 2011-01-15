task :default => :test

task :test do
  require File.expand_path(File.join(File.dirname(__FILE__), 'test/sheller_test'))
end

require 'rake/gempackagetask'
$: << File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
require File.join(File.dirname(__FILE__), 'lib/sheller.rb')

spec = Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.summary      = "Simplified, unified interface to shell commands"
  s.name         = 'sheller'
  s.version      = Sheller::VERSION
  s.add_dependency('POpen4', '>= 0.1.4')
  s.require_path = 'lib'
  s.files        = FileList["lib/**/*", "test/**/*"].exclude(/\.gitignore/)
  s.description  = "Simplified, unified interface to shell commands"
  s.homepage     = "http://github.com/duncanbeevers/sheller"
  s.author       = "Duncan Beevers"
  s.email        = "duncan@dweebd.com"
end

Rake::GemPackageTask.new(spec) do |pkg|
end
