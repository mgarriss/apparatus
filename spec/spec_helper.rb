require 'rubygems'
require 'spork'

require 'rspec'
require 'rspec/mocks'
include RSpec::Mocks::ExampleMethods

require 'apparatus'
include Apparatus

def cells
  8.times do |col|
    8.times do |row|
      yield col, row, (row * 16) + row
    end
  end
end

def machine
  EM::run_block do
    begin
      yield
    ensure
      EM::stop_event_loop
    end
  end
end

RSpec.configure do |config|
  config.filter_run_excluding pending:true
  config.fail_fast = true
  config.mock_with :rspec
  config.profile_examples = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus:true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
  end
  
  config.after(:suite) do
  end
  
  config.before(:all) do
    # @input = Pipe.new
    # @output = Pipe.new
  end
  
  config.after(:all) do
    # @input.detach!
    # @output.detach!
  end
end
