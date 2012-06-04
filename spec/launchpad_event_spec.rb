require 'spec_helper'

describe Lpad::Event do
  before :all do
    LpadEvent = Lpad::Event.new('LpadEvent')
    # LpadEvent.tap_threshold = 0.5
    LpadEvent >> (@a = Agent.new)
  end
  
  cells do |col,row,pitch|
    unless col == 0
      it "{name:'on',col:#{col},row:#{row}} followed by " +
        "{name:'off',col:#{col},row:#{row}} with in LpadEvent.tap_threshold >> "  +
        "{name:'tap',col:#{col},row:#{row}"  do
        LpadEvent << {name:'on',col:col,row:row}
        LpadEvent << {name:'on',col:(col-1),row:row}
        sleep(LpadEvent.tap_threshold/4.0)
        LpadEvent << {name:'off',col:col,row:row}
        LpadEvent << {name:'off',col:(col-1),row:row}
        wait do
          LpadEvent.production.should include({name:'tap',col:col,row:row})
          LpadEvent.production.should_not include({name:'hold',col:col,row:row})
          LpadEvent.production.should_not include({name:'release',col:col,row:row})
          LpadEvent.production.should include({name:'tap',col:(col-1),row:row})
          LpadEvent.production.should_not include({name:'hold',col:(col-1),row:row})
          LpadEvent.production.should_not include({name:'release',col:(col-1),row:row})
        end
      end
      
      it "{name:'on',col:#{col},row:#{row}} followed by " +
        "{name:'off',col:#{col},row:#{row}} after LpadEvent.tap_threshold >> "  +
        "{name:'hold',col:#{col},row:#{row}"  do
        LpadEvent << {name:'on',col:col,row:row}
        LpadEvent << {name:'on',col:(col-1),row:row}
        sleep(LpadEvent.tap_threshold*4.0)
        sleep(LpadEvent.tap_threshold*4.0)
        LpadEvent << {name:'off',col:col,row:row}
        LpadEvent << {name:'off',col:(col-1),row:row}
        wait do
          LpadEvent.production.should include({name:'hold',col:col,row:row})
          LpadEvent.production.should include({name:'release',col:col,row:row})
          LpadEvent.production.should_not include({name:'tap',col:col,row:row})
          LpadEvent.production.should include({name:'hold',col:(col-1),row:row})
          LpadEvent.production.should include({name:'release',col:(col-1),row:row})
          LpadEvent.production.should_not include({name:'tap',col:(col-1),row:row})
        end
      end
    end
  end
end
