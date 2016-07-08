$:.push File.expand_path("../lib", __FILE__)

require "twilivery/version"

Gem::Specification.new do |s|
  s.name        = 'twilivery'
  s.version     = Twilivery::VERSION
  s.authors     = ["Jesse Curry"]
  s.email       = ['jesse@jessecurry.net']
  s.homepage    = 'https://github.com/jessecurry/twilivery'
  s.summary     = "Twilivery for Rails"
  s.description = "Delivery Method for Rails ActionMailer to send SMS messages using the Twilio API"
  s.license     = 'MIT'

  s.files = Dir["{lib}/**/*"] + ["LICENSE", "README.md"]
  s.test_files = Dir["{spec}/**/*"]

  s.add_dependency 'rails', '>= 4.0', '< 5.1'
  s.add_dependency 'twilio-ruby', '~> 4.11.1'
  s.add_dependency 'phony_rails'

  s.add_development_dependency "rspec", '>= 3.4.0'
end
