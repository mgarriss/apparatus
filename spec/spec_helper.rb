require 'rubygems'

require 'rspec'
require 'rspec/mocks'
include RSpec::Mocks::ExampleMethods

require 'apparatus'
include Apparatus

RSpec.configure do |config|
  config.filter_run_excluding pending:true
  config.fail_fast = true
  config.mock_with :rspec
  config.profile_examples = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus:true
  config.run_all_when_everything_filtered = true
  config.backtrace_clean_patterns <<  /org\.jruby/
  config.before(:suite) do
    Apparatus.start
  end
end

def cells
  2.times do |col|
    2.times do |row|
      yield col, row, (row * 16) + col
    end
  end
end

def wait
  if block_given?
    sleep 0.05
    EM.next_tick do
      yield
    end
  end
  sleep 0.05
end
