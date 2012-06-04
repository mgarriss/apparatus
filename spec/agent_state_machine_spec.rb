require 'spec_helper'

describe "Agent state_machine" do
  before :each do
    @a = Agent.new '@a'
    @b = Agent.new '@b'
    @c = Agent.new '@c'
    wait do
      @a << @b << @c
    end
  end
  
  it 'starts in :deactivated' do
    Agent.new.deactivated?.should be_true
  end
  
  it 'moves to :activated after first attachment' do
    @a.activated?.should be_true
  end
  
  it 'moves to :deactivated if it can\t communicate with attachments'

  it 'unattaches on a unattach! event',:pending do
    wait do
      @a.unattach!
      @b << [:a,1]
    end
    @b.received.should eq([:a,1])
    @b.produced.should be_nil
    @a.received.should be_nil
    @a.produced.should be_nil
  end
  
  it 'can replace itself inplace, reattaching all attachments',:pending do
    wait do
      @a.unattach!
      @b << [:a,1]
    end
    wait do
      @a.reattach!
    end
    wait do
      @b << [:b,2]
    end
    @b.received.should eq([:b,2])
    @b.produced.should eq([:b,2])
    @a.received.should eq([:b,2])
    @a.produced.should be_nil
  end
end
