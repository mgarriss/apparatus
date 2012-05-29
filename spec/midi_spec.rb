require 'spec_helper'

describe MIDI do
  before do
    @input = MIDI::Input.find('to Apparatus').start
    @output = MIDI::Output.find('to Apparatus').start
    wait
  end
  
  after(:each) do
    @output.kill
    @input.kill
  end

  it 'output behaves like an agent' do
    @output << [144,5,5]
    wait
    @output.received.should eq([144,5,5])
    @output.produced.should eq([144,5,5])
  end
  
  it 'the MIDI port reports the same message it received' do
    @output << [144,5,5]
    wait
    @output.received.should eq([144,5,5])
    @input.received.should eq([144,5,5])
  end
  
  it 'output is sent out' do
    @input >> (agent = Agent.new)
    wait
    @input.attached_to_output?.should be_true
    @output << [176,5,5]
    @input.stub(:timestamp).and_return(0.0)
    wait
    @input.received.should eq([176,5,5])
    @output.received.should eq([176,5,5])
    @output.produced.should eq([176,5,5])
    agent.received.should eq([176,5,5])
  end
end
