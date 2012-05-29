require 'spec_helper'

describe App do
  it 'accepts the CC messages' do
    AppOut << ['cc',56,0]
    wait
    AppOut.received.should eq(['cc',56,0])
    AppOut.produced.should eq([176,0,56])
  end
  
  it 'receives CC messages' do
    @from_app = App::Input.find('from Apparatus')
    @from_app >> (agent = Agent.new)
    wait
    AppOut << ['cc',56,0]
    wait
    @from_app.produced.should eq(['cc',56,0])
    agent.received.should eq(['cc',56,0])
  end
  
  it 'accepts the note messages' do
    AppOut << ['on',23,34]
    wait
    AppOut.received.should eq(['on',23,34])
    AppOut.produced.should eq([144,23,34])
  end
  
  it 'receives note messages' do
    @from_app = App::Input.find('from Apparatus')
    @from_app >> (agent = Agent.new)
    wait
    AppOut << ['on',23,34]
    wait
    @from_app.produced.should eq(['on',23,34])
    agent.received.should eq(['on',23,34])
  end
end
