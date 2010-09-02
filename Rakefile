require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.dirname(__FILE__) + "/lib/liquidplanner.rb"

require 'rubygems'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = "liquidplanner"
    gemspec.summary     = "LiquidPlanner API client"
    gemspec.version     = LiquidPlanner::VERSION
    gemspec.description = "LiquidPlanner API client, using ActiveResource"
    gemspec.email       = "api@liquidplanner.com"
    gemspec.homepage    = "http://github.com/liquidplanner/liquidplanner"
    gemspec.authors     = ["Brett Bender", "Adam Sanderson"]
    
    gemspec.files       = FileList["[A-Z]*", "{examples,lib,test}/**/*"]
    
    gemspec.add_dependency              'activeresource',   '~> 3.0.0', '>= 3.0.0' # Ensure that we do not use beta gems
    gemspec.add_dependency              'activesupport',    '~> 3.0.0', '>= 3.0.0' # Ensure that we do not use beta gems
    gemspec.add_dependency              'multipart-post',   '~> 1.0.1', '>= 1.0.1'

    # For the examples:
    gemspec.add_development_dependency  'highline',         '>= 1.5'
    gemspec.add_development_dependency  'mocha',            '= 0.9.8'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

Rake::RDocTask.new do |t|
  t.main = "README.rdoc"
  t.rdoc_files.include("README.rdoc")
  t.rdoc_files.include("lib/**/*.rb")
end