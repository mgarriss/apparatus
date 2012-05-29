require 'spec_helper'

describe Agent do
  [:new,:start].each do |create|
    before do
      @a = Agent.send(create,'@a')
      @b = Agent.send(create,'@b')
      @c = Agent.send(create,'@c')
    end
    
    it 'has a #member that shuts down' do
      @a.kill
      @a.alive?.should be_false
      (@a << 'dude').should be_nil
      wait
      @a.received.should be_nil
      @a.produced.should be_nil
    end
    
    it 'has a #attached_to_input?' do
      @a.attached_to_input?.should be_false
      @a << @b
      @a.attached_to_input?.should be_true
    end
    
    it 'has a #attached_to_output?' do
      @a.attached_to_output?.should be_false
      @a >> @b
      @a.attached_to_output?.should be_true
    end
    
    it 'has a #received member that stores last received' do
      @a << [:a,5]
      wait
      @a.received.should eq([:a,5])
      @a.produced.should be_nil
    end
    
    it 'has a #produced member that stores last produced' do
      @b << @a << [:a,5]
      wait
      @a.produced.should eq([:a,5])
      @b.produced.should be_nil
    end
    
    it 'chains 3 agents' do
      @a << @c << @b
      wait
      @b << 'a string'
      wait
      @b.received.should eq('a string')
      @c.received.should eq('a string')
      @a.received.should eq('a string')
    end
    
    it 'chains 3 agents with >>' do
      {a:'hash'} >> @a >> @c >> @b
      wait
      @b.received.should eq({a:'hash'})
      @c.received.should eq({a:'hash'})
      @a.received.should eq({a:'hash'})
    end
    
    it 'only attaches to one other agent',:pending do
      @a >> @c
      @a >> @b
      @a << {b:'hash'}
      wait
      @b.received.should eq({b:'hash'})
      @c.received.should be_nil # eq({b:'hash'})
      @a.received.should eq({b:'hash'})
    end
    
    it '#attach is an alias for <<' do
      @a.attach(@c).attach(@b)
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
      agent = Agent.new << @a
      @a << [[:a],[:b]]
      wait
      agent.received.should eq([[:a],[:b]])
    end
    
    it 'has a class level << that chains' do
      agent = Agent.new << Agent.new << @a
      @a << [[:a],[:b]]
      wait
      agent.received.should eq([[:a],[:b]])
    end
    
    it 'has a class level >> that chains' do
      @a >> (agent = Agent.new)
      @a << [[:a],[:b]]
      wait
      agent.received.should eq([[:a],[:b]])
    end
    
    it 'names itself it\'s class name if no name given' do
      a = Agent.new
      a.name.should eq('Apparatus::Agent')
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
          loop do
            object_out 'hello'
            wait
          end
        end
      end
      @a << (agent = HelloAgent.send(create))
      wait; wait
      @a.received.should eq('hello')
      agent.kill
    end
    
    it 'supports subclassing by overriding both' do
      class TenPlusOneAgent < Agent
        def generate
          loop do
            react_to 10
            wait
          end
        end
        def react_to(data)
          object_out(data + 1)
        end
      end
      @a << (agent = TenPlusOneAgent.send(create))
      wait; wait
      @a.received.should eq(11)
      agent.kill
    end
    
    it 'adds >> to Hash' do
      proc{{a:4}}.should_not raise_error
    end
    
    it 'adds >> to Array' do
      proc{[1]}.should_not raise_error
    end
    
    it 'adds >> to String' do
      proc{'asd'}.should_not raise_error
    end
    
    it 'adds >> to Symbol' do
      proc{:a}.should_not raise_error
    end
    
    it 'broadcasts a message to many when attached to an array of agents' do
      @a >> [@c,@b]
      wait
      @a << [5,6]
      wait
      @a.received.should eq([5,6])
      @c.received.should eq([5,6])
      @b.received.should eq([5,6])
    end
    
    it 'start creates a threaded agent' do
      Agent.new.threaded?.should be_false
      Agent.start.threaded?.should be_true
    end
  end
end
