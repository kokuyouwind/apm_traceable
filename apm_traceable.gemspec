# frozen_string_literal: true

require_relative 'lib/apm_traceable/version'

Gem::Specification.new do |spec|
  spec.name = 'apm_traceable'
  spec.version = ApmTraceable::VERSION
  spec.authors = ['kokuyouwind']
  spec.email = ['kokuyouwind@gmail.com']

  spec.summary = 'APM Traceable'
  spec.description = 'Tracer to facilitate tracking of method calls, etc. in APM'
  spec.homepage = 'https://github.com/kokuyouwind/apm_traceable'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/kokuyouwind/apm-traceable'
  spec.metadata['changelog_uri'] = 'https://github.com/kokuyouwind/apm-traceable'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.metadata['rubygems_mfa_required'] = 'true'
end
