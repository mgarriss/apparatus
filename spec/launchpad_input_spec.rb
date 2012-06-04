require 'spec_helper'

describe Lpad::Input do
  before :all do
    LpadIn = Lpad::Input.find('to Apparatus')
    AppOut = App::Output.find('to Apparatus')
    LpadIn >> Agent.new
  end
  
  cells do |col,row,pitch|
    it "144,#{pitch},127 -> {name:'on',col:#{col},row:#{row}}" do
      AppOut << {name:'on',pitch:pitch,velocity:127}
      wait do
        AppOut.received.should eq({name:'on',pitch:pitch,velocity:127})
        AppOut.produced.should eq([144,pitch,127])
      end
      wait do
        # LpadIn.received.should eq([144,pitch,127])
        LpadIn.produced.should eq({name:'on',col:col,row:row})
      end
    end
    
    it "144,#{pitch},0 -> {name:'off',col:#{col},row:#{row}}" do
      AppOut << {name:'off',pitch:pitch}
      wait do
        AppOut.received.should eq({name:'off',pitch:pitch})
        AppOut.produced.should eq([128,pitch,0])
      end
      wait do
        # LpadIn.received.should eq([128,pitch,0])
        LpadIn.produced.should eq({name:'off',col:col,row:row})
      end
    end
  end
end
