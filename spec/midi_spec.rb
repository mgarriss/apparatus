require 'spec_helper'

describe MIDI do
  before :all do
    @input = MIDI::Input.find('to Apparatus')
    @output = MIDI::Output.find('to Apparatus')
  end
  
  after :all do
    @input.close
    @output.close
  end
  
  it 'output behaves like an agent' do
    @output.should_receive(:object_in).with([144,5,5])
    @output << [144,5,5]
  end
  
  it 'the MIDI port reports the same message it received' do
    @input.should_receive(:object_in).with([144,5,5])
    @output << [144,5,5]
  end
  
  it 'output is sent out' do
    @input.should_receive(:object_in).with([176,5,5])
    @output << [176,5,5]
  end
end
