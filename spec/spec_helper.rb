require 'rubygems'
require 'spork'
require 'rspec'
require 'rspec/mocks'

include RSpec::Mocks::ExampleMethods

def cells
  8.times do |col|
    8.times do |row|
      yield col, row, (row * 16) + row
    end
  end
end

Spork.prefork do
  require 'unimidi'
  
  RSpec.configure do |config|
    config.filter_run_excluding :pending => true
    config.fail_fast = true
    config.mock_with :rspec
    config.profile_examples = true
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
  end
end

Spork.each_run do
  RSpec.configure do |config|
  end
end
