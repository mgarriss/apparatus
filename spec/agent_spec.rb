require 'spec_helper'

describe Agent do
  before do
    @a = Agent.new('@a')
    @b = Agent.new('@b')
    @c = Agent.new('@c')
  end
  
  it 'has a #received member that stores last received' do
    @a << [:a,5]
    wait
    @a.received.should eq([:a,5])
  end
  
  it 'chains 3 agents' do
    @a << @c << @b
    
    @b.received.should be_nil
    @c.received.should be_nil
    @a.received.should be_nil
    
    @b << 'a string'
    
    wait
    
    @b.received.should eq('a string')
    @c.received.should eq('a string')
    @a.received.should eq('a string')
  end
  
  it 'chains 3 agents with >>' do
    @a >> @c >> @b
    
    @b.received.should be_nil
    @c.received.should be_nil
    @a.received.should be_nil
    
    @b << {a:'hash'}
    
    wait
    
    @b.received.should eq({a:'hash'})
    @c.received.should be_nil
    @a.received.should be_nil
    
    @a << {a:'hash2'}
    
    wait
    
    @b.received.should eq({a:'hash2'})
    @c.received.should eq({a:'hash2'})
    @a.received.should eq({a:'hash2'})
  end
  
  it 'only attaches to one other agent',:pending do
    @a >> @c
    @a >> @b
    
    @b.received.should be_nil
    @c.received.should be_nil
    @a.received.should be_nil
    
    @a << {b:'hash'}
    
    wait
    
    @b.received.should eq({b:'hash'})
    @c.received.should be_nil # eq({b:'hash'})
    @a.received.should eq({b:'hash'})
  end
  
  it '#attach is an alias for <<' do
    @a.attach(@c).attach(@b)
    
    @b.received.should be_nil
    @c.received.should be_nil
    @a.received.should be_nil
    
    @b << [:dude,:ham]
    
    wait
    
    @b.received.should eq([:dude,:ham])
    @c.received.should eq([:dude,:ham])
    @a.received.should eq([:dude,:ham])
  end

  it 'has a class level attach' do
    agent = Agent.attach(@a)
    @a << [[:a],[:b]]
    wait
    agent.received.should eq([[:a],[:b]])
  end
  
  it 'has a class level <<' do
    agent = Agent << @a
    @a << [[:a],[:b]]
    wait
    agent.received.should eq([[:a],[:b]])
  end
  
  it 'has a class level << that chains' do
    agent = Agent << Agent << @a
    @a << [[:a],[:b]]
    wait
    agent.received.should eq([[:a],[:b]])
  end
  
  it 'supports subclassing by overriding #react_to' do
    class AddOneAgent < Agent
      def react_to(data)
        object_out(data + 1)
      end
    end
    
    @a << AddOneAgent << 5
    wait
    @a.received.should eq(6)
  end
  
  it 'supports subclassing by overriding #generate' do
    class HelloAgent < Agent
      def generate
        react_to 'hello'
      end
    end
    
    @a << HelloAgent
    wait
    
    @a.received.should eq('hello')
  end
  
  it 'supports subclassing by overriding both' do
    class TenPlusOneAgent < Agent
      def generate
        react_to 10
      end
      
      def react_to(data)
        object_out(data + 1)
      end
    end
    
    @a << TenPlusOneAgent
    wait
    
    @a.received.should eq(11)
  end
end
