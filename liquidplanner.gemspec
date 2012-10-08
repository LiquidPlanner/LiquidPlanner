Gem::Specification.new do |s|
  s.name        = "liquidplanner"
  s.version     = "0.0.5"
  s.authors     = ["Brett Bender", "Adam Sanderson", "Mark Holton"]
  s.email       = ["api@liquidplanner.com"]
  s.homepage    = "http://github.com/liquidplanner/liquidplanner"
  s.summary     = "LiquidPlanner API client"
  s.description = "LiquidPlanner API client"

  s.files = Dir["{lib,examples}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency 'activeresource',   '~> 3.0.0', '>= 3.0.0'
  s.add_runtime_dependency 'activesupport',    '~> 3.0.0', '>= 3.0.0'
  s.add_runtime_dependency 'multipart-post',   '~> 1.0.1', '>= 1.0.1'
  
  s.add_development_dependency 'highline',     '>= 1.5'
  s.add_development_dependency 'mocha',        '= 0.9.8'
end