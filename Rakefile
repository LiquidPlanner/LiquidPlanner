require 'rake'
require 'rake/testtask'

require File.dirname(__FILE__) + "/lib/liquidplanner.rb"

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end