require 'spec_helper'

describe Lpad::Input do
  before :all do
    LpadIn = Lpad::Input.find('to Apparatus')
    AppOut = App::Output.find('to Apparatus')
  end
  
  after :all do
    LpadIn.close
    AppOut.close
  end
  
  cells do |col,row,pitch|
    it "144,#{pitch},127 -> {name:'on',col:#{col},row:#{row}}" do
      LpadIn.should_receive(:object_in).with([144,pitch,127])
      AppOut << {name:'on',pitch:pitch,velocity:127}
      sleep 1
    end
    
    it "144,#{pitch},0 -> {name:'off',col:#{col},row:#{row}}" do
      LpadIn.should_receive(:react_to).with([128,pitch,0])
      AppOut << {name:'off',pitch:pitch}
    end
  end
end
