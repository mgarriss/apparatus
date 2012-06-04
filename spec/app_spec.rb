require 'spec_helper'

describe App do
  before :all do
    AppOut = App::Output.find('from Apparatus')
  end
  
  it 'accepts the CC messages' do
    AppOut.should_receive(:object_in).with({name:'cc',number:56,value:0})
    AppOut << {name:'cc',number:56,value:0}
  end
  
  it 'produces CC messages' do
    AppOut.should_receive(:object_out).with([176,0,56])
    AppOut << {name:'cc',number:56,value:0}
  end
  
  it 'receives CC messages',:pending do
    @from_app = App::Input.find('from Apparatus')
    @from_app >> (agent = Agent.new)
    AppOut << {name:'cc',number:56,value:0}
    @from_app.received.should eq([176,0,56])
    @from_app.produced.should eq({name:'cc',number:56,value:0})
    agent.received.should eq({name:'cc',number:56,value:0})
  end
  
  it 'accepts the note messages',:pending do
    AppOut << {name:'on',pitch:23,velocity:34}
    AppOut.received.should eq({name:'on',pitch:23,velocity:34})
    AppOut.produced.should eq([144,23,34])
  end
  
  it 'receives note messages',:pending do
    @from_app = App::Input.find('from Apparatus')
    @from_app >> (agent = Agent.new)
    AppOut << {name:'on',pitch:23,velocity:34}
    @from_app.produced.should eq({name:'on',pitch:23,velocity:34})
    agent.received.should eq({name:'on',pitch:23,velocity:34})
  end
end
