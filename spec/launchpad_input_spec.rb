require 'spec_helper'

describe Lpad::Input do
  before :all do
    LpadIn = Lpad::Input.find('to Apparatus')
    AppOut = App::Output.find('to Apparatus')
    LpadIn >> Agent.new
  end
  
  before :each do
    LpadIn.stub(:timestamp).and_return(0.0)
  end
  
  cells do |col,row,pitch|
    it "144,#{pitch},127 -> {name:'on',col:#{col},row:#{row},time:0.0}" do
      AppOut << ['on',pitch,127]
      wait
      AppOut.received.should eq(['on',pitch,127])
      AppOut.produced.should eq([144,pitch,127])
      LpadIn.received.should eq([144,pitch,127])
      LpadIn.produced.should eq({name:'on',col:col,row:row,time:0.0})
    end
    
    it "144,#{pitch},0 -> {name:'off',col:#{col},row:#{row},time:0.0}" do
      AppOut << ['off',pitch,0]
      wait
      AppOut.received.should eq(['off',pitch,0])
      AppOut.produced.should eq([144,pitch,0])
      # LpadIn.received.should eq([144,pitch,0])
      LpadIn.produced.should eq({name:'on',col:col,row:row,time:0.0})
    end
  end
end
