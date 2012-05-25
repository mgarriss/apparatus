require 'spec_helper'
require 'apparatus/event_builder'

include Apparatus

describe EventBuilder do
  before :all do
    @input = EM::Channel.new
    @output = double 'output'
    @event_builder = EventBuilder.new(@input,@output)
  end
  
  before :each do
    @event_builder.stub(:get_timestamp).and_return(0.0)
  end
end
