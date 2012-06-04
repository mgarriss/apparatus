require 'spec_helper'

describe Lpad::Event do
  before :all do
    LpadEvent = Lpad::Event.new('LpadEvent')
  end
  
  cells do |col,row,pitch|
    it "{name:'on',col:#{col},row:#{row}} followed by " +
        "{name:'off',col:#{col},row:#{row}} with in " + 
        "LpadEvent.tap_threshold >> "  +
        "{name:'tap',col:#{col},row:#{row}"  do
      LpadEvent.should_receive(:object_out).with \
        ({name:'tap',col:col,row:row})
      LpadEvent << {name:'on',col:col,row:row}
      sleep(LpadEvent.tap_threshold/4.0)
      LpadEvent << {name:'off',col:col,row:row}
    end
    
    it "{name:'on',col:#{col},row:#{row}} " + 
        "LpadEvent.tap_threshold >> "  +
        "{name:'hold',col:#{col},row:#{row}"  do
      LpadEvent.should_receive(:object_out).with \
        ({name:'hold',col:col,row:row})
      LpadEvent << {name:'on',col:col,row:row}
      sleep(LpadEvent.tap_threshold*4.0)
    end
    
    it "{name:'on',col:#{col},row:#{row}} followed by " +
        "{name:'off',col:#{col},row:#{row}} after " +
        "LpadEvent.tap_threshold >> "  +
        "{name:'release',col:#{col},row:#{row}"  do
      LpadEvent.should_receive(:object_out)
      LpadEvent.should_receive(:object_out).with \
        ({name:'release',col:col,row:row})
      LpadEvent << {name:'on',col:col,row:row}
      sleep(LpadEvent.tap_threshold*4.0)
      LpadEvent << {name:'off',col:col,row:row}
    end
  end
end
