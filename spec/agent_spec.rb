require 'spec_helper'

describe Agent do
  before :each do
    @a = Agent.new '@a'
    @b = Agent.new '@b'
    @c = Agent.new '@c'
  end
  
  it 'has a #object_in' do
    @a.should_receive(:object_in).with([:a,5])
    @a << [:a,5]
  end
  
  it 'has a #object_in that chains' do
    @b.should_receive(:object_in).with([:a,5])
    @b << @a << [:a,5]
  end
  
  it 'chains 3 agents' do
    @b.should_receive(:object_in).with('a string')
    @a << @c << @b
    @b << 'a string'
  end
  
  it 'chains 3 agents with >>' do
    @b.should_receive(:object_in).with({a:'hash'})
    {a:'hash'} >> @a >> @c >> @b
  end
  
  it 'names itself it\'s class name if no name given' do
    a = Agent.new
    a.name.should eq('Apparatus::Agent')
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
end
