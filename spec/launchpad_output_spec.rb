require 'spec_helper'

describe Lpad::Output do
  before :all do
    LpadOut = Lpad::Output.find('to Apparatus')
    wait
  end
  
  cells do |col,row,pitch|
    it "{name:'on',col:#{col},row:#{row}} - > 144,#{pitch},127" do
      LpadOut << {name:'on',col:col,row:row}
      wait; wait
      LpadOut.received.should eq({name:'on',col:col,row:row})
      LpadOut.produced.should eq([144,pitch,127])
    end
    
    it "144,#{pitch},0 -> {name:'off',col:#{col},row:#{row}" do
      LpadOut << {name:'off',col:col,row:row}
      wait; wait
      LpadOut.received.should eq({name:'off',col:col,row:row})
      LpadOut.produced.should eq([128,pitch,0])
    end
  end
  
  describe 'default of full' do
    it "sends a velocity of 15 for name:'red'" do
      LpadOut << {name:'red',col:3,row:2}
      wait; wait
      LpadOut.received.should eq({name:'red',col:3,row:2})
      LpadOut.produced.should eq([144,35,15])
    end
    
    it "sends a velocity of 60 for name:'green'" do
      LpadOut << {name:'green',col:3,row:2}
      wait; wait
      LpadOut.received.should eq({name:'green',col:3,row:2})
      LpadOut.produced.should eq([144,35,60])
    end
    
    it "sends a velocity of 62 for name:'yellow'" do
      LpadOut << {name:'yellow',col:3,row:2}
      wait; wait
      LpadOut.received.should eq({name:'yellow',col:3,row:2})
      LpadOut.produced.should eq([144,35,62])
    end
    
    it "sends a velocity of 63 for name:'amber'" do
      LpadOut << {name:'amber',col:3,row:2}
      wait; wait
      LpadOut.received.should eq({name:'amber',col:3,row:2})
      LpadOut.produced.should eq([144,35,63])
    end
  end

  describe 'brightness set to full' do
    it "sends a velocity of 15 for name:'red'" do
      LpadOut << {name:'red',col:3,row:2,brightness:'full'}
      wait; wait
      LpadOut.received.should eq({name:'red',col:3,row:2,brightness:'full'})
      LpadOut.produced.should eq([144,35,15])
    end
    
    it "sends a velocity of 60 for name:'green'" do
      LpadOut << {name:'green',col:3,row:2,brightness:'full'}
      wait; wait
      LpadOut.received.should eq({name:'green',col:3,row:2,brightness:'full'})
      LpadOut.produced.should eq([144,35,60])
    end
    
    it "sends a velocity of 62 for name:'yellow'" do
      LpadOut << {name:'yellow',col:3,row:2,brightness:'full'}
      wait; wait
      LpadOut.received.should eq({name:'yellow',col:3,row:2,brightness:'full'})
      LpadOut.produced.should eq([144,35,62])
    end
    
    it "sends a velocity of 63 for name:'amber'" do
      LpadOut << {name:'amber',col:3,row:2}
      wait; wait
      LpadOut.received.should eq({name:'amber',col:3,row:2})
      LpadOut.produced.should eq([144,35,63])
    end
  end
  
  describe 'brightness set to low' do
    it "sends a velocity of 13 for name:'red'" do
      LpadOut << {name:'red',col:3,row:2,brightness:'low'}
      wait; wait
      LpadOut.received.should eq({name:'red',col:3,row:2,brightness:'low'})
      LpadOut.produced.should eq([144,35,13])
    end
    
    it "sends a velocity of 62 for name:'yellow'" do
      LpadOut << {name:'yellow',col:3,row:2,brightness:'low'}
      wait; wait
      LpadOut.received.should eq({name:'yellow',col:3,row:2,brightness:'low'})
      LpadOut.produced.should eq([144,35,62])
    end
    
    it "sends a velocity of 28 for name:'green'" do
      LpadOut << {name:'green',col:3,row:2,brightness:'low'}
      wait; wait
      LpadOut.received.should eq({name:'green',col:3,row:2,brightness:'low'})
      LpadOut.produced.should eq([144,35,28])
    end
    
    it "sends a velocity of 29 for name:'amber'" do
      LpadOut << {name:'amber',col:3,row:2,brightness:'low'}
      wait; wait
      LpadOut.received.should eq({name:'amber',col:3,row:2,brightness:'low'})
      LpadOut.produced.should eq([144,35,29])
    end
  end
end
