require 'spec_helper'

# these tests require you to have a MIDI in/out device named 'Apparatus

describe Lpad::Input, :focus do
  before :all do
    LpadIn = Lpad::Input.find('to Apparatus')
    AppOut = App::Output.find('to Apparatus')
  end
  
  before :each do
    LpadIn.clear
    LpadIn.stub(:timestamp).and_return(0.0)
  end
  
  after :all do
    LpadIn.close
  end
  
  cells do |col,row,pitch|
    it "144,#{pitch},127 -> {name:'on',col:#{col},row:#{row},time:0.0}" do
      AppOut << [144,pitch,127]
      wait
      AppOut.received.should eq([144,pitch,127])
      AppOut.produced.should eq([144,pitch,127])
      p LpadIn
      LpadIn.received.should eq([144,pitch,127])
      LpadIn.produced.should eq({name:'on',col:col,row:row,time:0.0})
    end
    
    it "144,#{pitch},0 -> {name:'off',col:#{col},row:#{row},time:0.0}" do
      AppOut << [144,pitch,0]
      wait
      AppOut.received.should eq([144,pitch,0])
      AppOut.produced.should eq([144,pitch,0])
      LpadIn.received.should eq([144,pitch,0])
      LpadIn.produced.should eq({name:'on',col:col,row:row,time:0.0})
    end
  end
end
