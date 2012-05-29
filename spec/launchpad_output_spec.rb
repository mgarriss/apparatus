require 'spec_helper'

describe Lpad::Output,:pending do
  before :all do
    LpadOut = Lpad::Output.find('to Apparatus')
    AppIn = App::Input.find('to Apparatus')
    AppIn >> Agent.new
    wait
  end
  
  cells do |col,row,pitch|
    it "144,#{pitch},127 -> {name:'on',col:#{col},row:#{row}}" do
      LpadOut << {name:'on',col:col,row:row}
      wait; wait; wait; wait
      LpadOut.received.should eq({name:'on',col:col,row:row})
      LpadOut.produced.should eq([144,pitch,127])
      AppIn.received.should eq([144,pitch,127])
      AppIn.produced.should eq(['on',pitch,127])
    end
    
    it "144,#{pitch},0 -> {name:'off',col:#{col},row:#{row}" do
      LpadOut << {name:'off',col:col,row:row}
      wait; wait; wait; wait
      LpadOut.received.should eq({name:'off',col:col,row:row})
      LpadOut.produced.should eq([128,pitch,0])
      # AppIn.received.should eq([128,pitch,0])
      AppIn.produced.should eq(['off',pitch,0])
    end
  end
end
