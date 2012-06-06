require 'spec_helper'

describe Lpad::Output do
  before :all do
    LpadOut = Lpad::Output.find('to Apparatus')
  end
  
  after :all do
    LpadOut.close
  end
  
  cells do |col,row,pitch|
    it "{name:'on',col:#{col},row:#{row}} - > 144,#{pitch},127" do
      LpadOut.should_receive(:object_out).with([144,pitch,127])
      LpadOut << {name:'on',col:col,row:row}
    end
    
    it "144,#{pitch},0 -> {name:'off',col:#{col},row:#{row}" do
      LpadOut.should_receive(:object_out).with([128,pitch,0])
      LpadOut << {name:'off',col:col,row:row}
    end
  end
  
  describe 'default of full' do
    it "sends a velocity of 15 for name:'red'" do
      LpadOut.should_receive(:object_out).with([144,35,15])
      LpadOut << {name:'red',col:3,row:2}
    end
    
    it "sends a velocity of 60 for name:'green'" do
      LpadOut.should_receive(:object_out).with([144,35,60])
      LpadOut << {name:'green',col:3,row:2}
    end
    
    it "sends a velocity of 62 for name:'yellow'" do
      LpadOut.should_receive(:object_out).with([144,35,62])
      LpadOut << {name:'yellow',col:3,row:2}
    end
    
    it "sends a velocity of 63 for name:'amber'" do
      LpadOut.should_receive(:object_out).with([144,35,63])
      LpadOut << {name:'amber',col:3,row:2}
    end
  end

  describe 'brightness set to full' do
    it "sends a velocity of 15 for name:'red'" do
      LpadOut.should_receive(:object_out).with([144,35,15])
      LpadOut << {name:'red',col:3,row:2,brightness:'full'}
    end
    
    it "sends a velocity of 60 for name:'green'" do
      LpadOut.should_receive(:object_out).with([144,35,60])
      LpadOut << {name:'green',col:3,row:2,brightness:'full'}
    end
    
    it "sends a velocity of 62 for name:'yellow'" do
      LpadOut.should_receive(:object_out).with([144,35,62])
      LpadOut << {name:'yellow',col:3,row:2,brightness:'full'}
    end
    
    it "sends a velocity of 63 for name:'amber'" do
      LpadOut.should_receive(:object_out).with([144,35,63])
      LpadOut << {name:'amber',col:3,row:2}
    end
  end
  
  describe 'brightness set to low' do
    it "sends a velocity of 13 for name:'red'" do
      LpadOut.should_receive(:object_out).with([144,35,13])
      LpadOut << {name:'red',col:3,row:2,brightness:'low'}
    end
    
    it "sends a velocity of 62 for name:'yellow'" do
      LpadOut.should_receive(:object_out).with([144,35,62])
      LpadOut << {name:'yellow',col:3,row:2,brightness:'low'}
    end
    
    it "sends a velocity of 28 for name:'green'" do
      LpadOut.should_receive(:object_out).with([144,35,28])
      LpadOut << {name:'green',col:3,row:2,brightness:'low'}
    end
    
    it "sends a velocity of 29 for name:'amber'" do
      LpadOut.should_receive(:object_out).with([144,35,29])
      LpadOut << {name:'amber',col:3,row:2,brightness:'low'}
    end
  end
end
