require 'spec_helper'

describe MIDI do
  before :all do
    @input = MIDI::Input.find('to Apparatus')
    @output = MIDI::Output.find('to Apparatus')
    wait
  end
  
  it 'output behaves like an agent' do
    @output << [144,5,5]
    wait do
      @output.received.should eq([144,5,5])
      @output.produced.should eq([144,5,5])
    end
  end
  
  it 'the MIDI port reports the same message it received' do
    @output << [144,5,5]
    wait do
      @output.received.should eq([144,5,5])
      @input.received.should eq([144,5,5])
    end
  end
  
  it 'output is sent out' do
    @input >> (agent = Agent.new)
    wait do
      @input.attached_to_output?.should be_true
      @output << [176,5,5]
      @input.stub(:timestamp).and_return(0.0)
    end
    wait do
      @input.received.should eq([176,5,5])
      @output.received.should eq([176,5,5])
      @output.produced.should eq([176,5,5])
      agent.received.should eq([176,5,5])
    end
  end
end
