require 'spec_helper'

describe "Agent state_machine",:pending do
  before :each do
    @a = Agent.new '@a'
  end
  
  it 'starts in :deactivated' do
    Agent.new.deactivated?.should be_true
  end
  
  it 'moves to :activated after first attachment',:pending do
    @a.activated?.should be_true
  end
  
  it 'moves to :deactivated if it can\t communicate with attachments'
  
  it 'unattaches on a unattach! event'
  
  it 'can replace itself inplace, reattaching all attachments'
end
