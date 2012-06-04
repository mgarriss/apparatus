require 'spec_helper'

describe Lpad::Effect,:pending do
  before do
    @w = 0.4
    LpadEffect = Lpad::Effect.new('LpadEffect')
    LpadEffect >> (@from_effect = Agent.new)
  end
  
  it 'passes colors thru' do
    LpadEffect << {name:'red',col:2,row:3}
    wait
    LpadEffect.produced.should eq({name:'red',col:2,row:3})
  end
  
  it 'passes off thru' do
    LpadEffect << {name:'off',col:2,row:3}
    wait
    LpadEffect.produced.should eq({name:'off',col:2,row:3})
  end
  
  describe ':wait and :then' do
    it 'a :wait without a :then turns same cell off after waiting' do
      LpadEffect << {name:'red',col:2,row:3,wait:@w}
      wait
      LpadEffect.produced.should eq({name:'red',col:2,row:3})
      sleep @w
      LpadEffect.produced.should eq({name:'off',col:2,row:3})
    end
    
    it 'a :then with just a :name effects same cell after waiting' do
      LpadEffect << {name:'red',col:2,row:3,wait:@w,then:{name:'amber'}}
      wait
      LpadEffect.produced.should eq({name:'red',col:2,row:3})
      sleep @w
      LpadEffect.produced.should eq({name:'amber',col:2,row:3})
    end
    
    it 'a :then with a full obj effects that obj' do
      LpadEffect << {name:'red',col:2,row:3,wait:@w,
                     then:{name:'amber',row:0,col:1}}
      wait
      LpadEffect.produced.should eq({name:'red',col:2,row:3})
      sleep @w
      LpadEffect.produced.should eq({name:'amber',col:1,row:0})
    end
    
    it 'a :then with a :dr and :dc effects the cell that distance away' do
      LpadEffect << {name:'red',col:2,row:3,wait:@w,
                     then:{name:'amber',dr:-1,dc:0}}
      wait
      LpadEffect.produced.should eq({name:'red',col:2,row:3})
      sleep @w
      LpadEffect.produced.should eq({name:'amber',col:2,row:2})
    end
    
    it 'a :then with a :dr and :dc that goes out is ignored' do
      LpadEffect << {name:'red',col:2,row:3,wait:@w,
                     then:{name:'amber',dr:0,dc:1}}
      wait
      LpadEffect.produced.should eq({name:'red',col:2,row:3})
      sleep @w
      LpadEffect.produced.should eq({name:'red',col:2,row:3})
    end
    
    it ':wait is recursive' do
      LpadEffect << {name:'red',col:2,row:3,wait:@w,
                     then:{name:'amber',dr:0,dc:1,wait:@w}}
      wait
      LpadEffect.produced.should eq({name:'red',col:2,row:3})
      sleep @w
      LpadEffect.produced.should eq({name:'amber',col:3,row:3})
      sleep @w
      LpadEffect.produced.should eq({name:'off',col:3,row:3})
    end
  end
end
