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
      yield col, row, (row * 16) + col
    end
  end
end

def wait
  sleep 0.02
end

class BasicObject
  class PutsHere
    def initialize(parent)
      @parent = parent
    end
    def method_missing(name,*args)
      print("  #{@parent.class}(#{_name}).#{name}(")
      print args.map{|e|e.inspect}.join(',')
      puts(')')
      puts
    end
    def _name
      if @parent.respond_to?(:name)
        @parent.name
      else
        @parent.object_id
      end
    end
  end

  def here(mess='')
    $stdout.puts "HERE(#{caller[1].split(':').last.to_s}) #{mess.inspect}"
    @here ||= PutsHere.new(self)
    @here
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
  config.backtrace_clean_patterns <<  /org\.jruby/
  
  config.before(:suite) do
    Apparatus.start
  end
  
  config.after(:suite) do
    Apparatus.stop
  end
end
