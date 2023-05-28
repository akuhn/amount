# frozen_string_literal: true

require "amount"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
end

class Binding
  def pry
    require 'pry'
    super
  end
end

def eth(units)
  Amount ETH: units
end
