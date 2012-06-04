require 'spec_helper'

describe App do
  before :all do
    AppOut = App::Output.find('from Apparatus')
  end
  
  it 'accepts the CC messages' do
    AppOut << {name:'cc',number:56,value:0}
    wait; wait; wait; wait
    wait do
      AppOut.received.should eq({name:'cc',number:56,value:0})
      AppOut.produced.should eq([176,0,56])
    end
  end
  
  it 'receives CC messages' do
    @from_app = App::Input.find('from Apparatus')
    @from_app >> (agent = Agent.new)

    wait; wait; wait; wait
    AppOut << {name:'cc',number:56,value:0}
    wait do
      @from_app.received.should eq([176,0,56])
      @from_app.produced.should eq({name:'cc',number:56,value:0})
      agent.received.should eq({name:'cc',number:56,value:0})
    end
  end
  
  it 'accepts the note messages' do
    AppOut << {name:'on',pitch:23,velocity:34}
    wait do
      AppOut.received.should eq({name:'on',pitch:23,velocity:34})
      AppOut.produced.should eq([144,23,34])
    end
  end
  
  it 'receives note messages' do
    @from_app = App::Input.find('from Apparatus')
    @from_app >> (agent = Agent.new)
    wait do
      AppOut << {name:'on',pitch:23,velocity:34}
    end
    wait do
      @from_app.produced.should eq({name:'on',pitch:23,velocity:34})
      agent.received.should eq({name:'on',pitch:23,velocity:34})
    end
  end
end
