# frozen_string_literal: true

require_relative "lib/amount/version"

Gem::Specification.new do |spec|
  spec.name = "amount"
  spec.version = Amount::VERSION
  spec.authors = ["Adrian Kuhn"]
  spec.email = ["akuhn@iam.unibe.ch"]

  spec.summary = "An amount of money with currency and 18-digit precision."
  spec.homepage = "https://github.com/akuhn/amount"
  spec.required_ruby_version = ">= 2.6.0"

  if spec.respond_to? :metadata
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata['source_code_uri'] = "https://github.com/akuhn/amount"
    spec.metadata['changelog_uri'] = "https://github.com/akuhn/amount/blob/master/lib/amount/version.rb"
  end

  spec.require_paths = ["lib"]
  spec.files = %w{
    README.md
    lib/amount.rb
    lib/amount/version.rb
  }

  spec.add_dependency 'fixed', '~> 1.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
