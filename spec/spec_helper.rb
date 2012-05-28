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

def wait
  sleep 1
end

class PutsHere
  def initialize(parent)
    @parent = parent
  end
  def method_missing(name,*args)
    puts("#{@parent.class}(#{@parent.object_id}).#{name}")
    args.each_with_index do |arg,i|
      puts("       arg[#{i}]: #{arg}")
    end
  end
end

class Object
  def here
    print "HERE: "
    @here ||= PutsHere.new(self)
    puts
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
