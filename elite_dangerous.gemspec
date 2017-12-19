lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "elite_dangerous/version"

Gem::Specification.new do |spec|
  spec.name          = "elite_dangerous"
  spec.version       = EliteDangerous::VERSION
  spec.authors       = ["Alexey I. Froloff"]
  spec.email         = ["raorn@raorn.name"]

  spec.summary       = %q{Elite:Dangerous Passenger Mission Helper}
  spec.description   = %q{Elite:Dangerous Passenger Mission Helper.}
#  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "gli"
  spec.add_dependency "json"
  spec.add_dependency "pg"
  spec.add_dependency "pry"
  spec.add_dependency "sequel"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency 'pry-rescue'
  spec.add_development_dependency 'pry-stack_explorer'
end
