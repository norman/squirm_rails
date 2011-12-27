require File.expand_path("../lib/squirm/rails/version", __FILE__)

Gem::Specification.new do |s|
  s.name          = "squirm_rails"
  s.version       = Squirm::Rails::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Norman Clarke"]
  s.email         = ["norman@njclarke.com"]
  s.homepage      = "http://github.com/bvision/squirm_rails"
  s.summary       = %q{"Easily use and manage Postgres stored procedures with Active Record."}
  s.description   = %q{"Squirm facilitates using Postgres stored procedures with Active Record."}
  s.bindir        = "bin"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 1.9"

  s.add_development_dependency "minitest"
  s.add_runtime_dependency "squirm", ">= 0.0.6"
  s.add_runtime_dependency "activerecord", ">= 3.0.0"
  s.add_runtime_dependency "railties"

end
