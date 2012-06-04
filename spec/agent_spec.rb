require 'spec_helper'

describe Agent do
  before :each do
    unless EM.reactor_running?
      warn "reactor claims to not be running"
    end
    @a = Agent.new '@a'
    @b = Agent.new '@b'
    @c = Agent.new '@c'
  end
  
  it 'has a #attached_to_input?' do
    @a.attached_to_input?.should be_false
    @a << @b
    wait
    EM.next_tick do
      @a.attached_to_input?.should be_true
    end
    wait
  end
  
  it 'has a #attached_to_output?' do
    @a.attached_to_output?.should be_false
    @a >> @b
    wait
    EM.next_tick do
      @a.attached_to_output?.should be_true
    end
    wait
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
    EM.next_tick do
      @a.received.should eq([:a,5])
      # @a.produced.should eq([:a,5])
      @b.produced.should be_nil
    end
  end
  
  it 'chains 3 agents',:pending do
    @a << @c << @b
    wait
    @b << 'a string'
    wait
    EM.next_tick do
      @b.received.should eq('a string')
      @c.received.should eq('a string')
      @a.received.should eq('a string')
    end
  end
  
  it 'chains 3 agents with >>' do
    {a:'hash'} >> @a >> @c >> @b
    wait
    EM.next_tick do
      @b.received.should eq({a:'hash'})
      @c.received.should eq({a:'hash'})
      @a.received.should eq({a:'hash'})
    end
  end
  
  it 'only attaches to one other agent',:pending do
    @a >> @c
    @a >> @b
    wait
    @a << {b:'hash'}
    wait
    @b.received.should eq({b:'hash'})
    @c.received.should be_nil # eq({b:'hash'})
    @a.received.should eq({b:'hash'})
  end
  
  it '#attach is an alias for <<',:pending do
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
    wait
    @a << [[:a],[:b]]
    wait
    agent.received.should eq([[:a],[:b]])
  end
  
  it 'has a class level << that chains' do
    agent = Agent.new << Agent.new << @a
    wait
    @a << [[:a],[:b]]
    wait
    agent.received.should eq([[:a],[:b]])
  end
  
  it 'has a class level >> that chains',:pending do
    @a >> (agent = Agent.new)
    wait
    @a << [[:a],[:b]]
    wait
    agent.received.should eq([[:a],[:b]])
  end
  
  it 'names itself it\'s class name if no name given' do
    a = Agent.new
    a.name.should eq('Apparatus::Agent')
  end
  
  it 'supports subclassing by overriding #react_to',:pending do
    class AddOneAgent < Agent
      def react_to(data)
        object_out(data + 1)
      end
    end
    @a << AddOneAgent << 5
    wait
    @a.received.should eq(6)
  end
  
  it 'supports subclassing by overriding #generate',:pending do
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
  
  it 'supports subclassing by overriding both',:pending do
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
  
  it 'has an overridable filter method' do
    class OnlyEvenAgent < Agent
      def filter(data)
        data % 2 == 0
      end
    end
    (agent = OnlyEvenAgent.new) >> Agent.new
    
    agent << 11
    wait do
      agent.received.should be_nil
      agent.produced.should be_nil
    end
    
    agent << 10
    wait do
      agent.received.should eq(10)
      agent.produced.should eq(10)
    end
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
    wait do
      @a.received.should eq([5,6])
      @c.received.should eq([5,6])
      @b.received.should eq([5,6])
    end
  end
end
