# Encoding: UTF-8
$:.push File.expand_path('../lib', __FILE__)
require 'refinery/registrable/version'

version = Refinery::Registrable::Version.to_s

Gem::Specification.new do |s|
  s.name              = %q{refinerycms-registrable}
  s.version           = version
  s.description       = %q{User registration comes to Refinery CMS.}
  s.summary           = %q{Allows users to register on Refinery CMS sites.}
  s.homepage          = %q{http://github.com/wenzowski/refinery-registrations}
  s.email             = %q{alexander@wenzowski.com}
  s.authors           = %q{Alexander Wenzowski}
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  # Runtime dependencies
  s.add_dependency    'refinerycms-core',     '~> 2.0.1'
  s.add_dependency    'refinerycms-settings', '~> 2.0.1'
  s.add_dependency    'simple_form'
end
