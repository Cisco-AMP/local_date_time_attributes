
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "local_date_time_attributes/version"

Gem::Specification.new do |spec|
  spec.name          = "local_date_time_attributes"
  spec.version       = LocalDateTimeAttributes::VERSION
  spec.authors       = ["Samson Nguyen"]
  spec.email         = ["samsnguy@cisco.com"]

  spec.summary       = %q{ ActiveRecord attributes api to define a DateTime attribute that ignores Time.zone}
  spec.description   = %q{Introduces a custom ActiveRecord attribute type which will ignore the timezone set by Time.zone. This is useful in the event we are modifying the current thread timezone}
  spec.homepage      = "https://github.com/Cisco-AMP/local_date_time_attributes"

  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    #spec.metadata["homepage_uri"] = spec.homepage
    #spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
    #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'activerecord'
end
