require 'spec_helper'
require 'apparatus/midi_receiver'

include Apparatus

# these tests require you to have a MIDI in/out device named 'Apparatus

describe MIDIReceiver do
  before :all do
    @output = double 'output'
    @input = UniMIDI::Output.all.find{|e| e.name == 'Apparatus'}
    @midi_receiver = MIDIReceiver.new('Apparatus',@output)
  end
  
  it 'raises Apparatus::UnknownMIDIInput' do
    lambda do 
      MIDIReceiver.new('foobar',@output)
    end.should_not raise_error(UnknownMIDIInput)
  end
  
  it 'connects to a named port' do
    lambda do 
      MIDIReceiver.new('Apparatus',@output)
    end.should_not raise_error
  end
  
  describe 'reading raw midi' do
    before :each do
      @midi_receiver.stub(:get_timestamp).and_return(1.0)
    end
    
    cells do |col,row,pitch|
      it "[:on, #{col},#{row}, 0.0] after 144,#{pitch},127" do
        @output.should_receive(:publish).with(144,pitch,0.0])
        @input.puts(144,0,127)
      end
      
      it "[:on, #{col},#{row}, 0.0] after 144,#{pitch},0" do
        @output.should_receive(:publish).with([:off,col,row,0.0])
        @input.puts(144,pitch,0)
      end
    end
  end
end
