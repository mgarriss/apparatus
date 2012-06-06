require 'spec_helper'

describe MIDI::Device do
  it 'is the base class for MIDI input and output' do
    MIDI::Input.superclass.should eq(MIDI::Device)
    MIDI::Output.superclass.should eq(MIDI::Device)
  end
end
