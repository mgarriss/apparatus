require 'spec_helper'

describe Page do
  before do
    LpadEvent = Lpad::Event.new('LpadEvent')
    LpadOut =  Lpad::Output.find('to Apparatus')
    AppOut = Lpad::Output.find('from Apparatus')
    AppIn = Agent.new('AppIn')
    
    @page = Page.new('MainPage') do
      to_activate do
        tap? and scene?(0)
      end
      
      to_deactivate do
        tap? and scene? and !scene?(0)
      end
      
      on_activate do
        object_out scene('red',0)
      end
      
      on_deactivate do
        object_out scene('off',0)
      end
      
      add_effect :flash_on, FlashOn, 'yellow'
      
      add_trigger(CornerTapped) do |obj|
        effect!(:flash_on,obj)
      end
      
      add_control :macro_1, CCtoCol, col:0, cc:14 
    end
  end
  
  it 'stores lpad event state' do
    @page << {name:'hold',col:3,row:6}
    wait do
      @page.on?(col:3,row:6).should be_true
      @page.off?(col:3,row:6).should be_false
      @page.on?(col:4,row:6).should be_false
      @page.off?(col:4,row:6).should be_true
    end
  end
  
  it 'is a subclass of Lpad::Effect' do
    Page.ancestors.should include(Apparatus::Lpad::Effect)
  end
end
