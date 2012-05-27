require 'spec_helper'
require 'apparatus/trigger'

include Apparatus

=begin
  trigger calls a given block and fires if the block returns 
    doesn't return nil or false
  the block is eval'd in the Trigger's instance so you have
    access to name(), x(), y(), xx(), and yy()
  the default  is to report it's name on it's output channel
=end

describe Trigger do
  before :all do
    @input = EM::Channel.new
    @output = double
    
    @trigger = Trigger.new('crazy town',@input,@output) do
      ((action == :tap) and (x == 0) and (y == 3)) or (x == 1)
    end
    
    @trigger.on_match do |output|
      output "action was #{action}"
    end
  end
  
  it 'calls a given block on a match' do
  end
end
