module Apparatus
  LpadOut = Lpad::Output.find('Launchpad')
  LpadIn = Lpad::Input.find('Launchpad')
  
  AppOut = App::Output.find('from Apparatus')
  AppIn = App::Input.find('to Apparatus')
  
  LpadEvent = Lpad::Event.new('LpadEvent')
  LpadEvent.tap_threshold = 0.08
  
  LpadEffect = Lpad::Effect.new('LpadEffect')

  EM.next_tick do
    LpadIn >> LpadEvent
    LpadEffect >> LpadOut
  end

  EM.next_tick do
    LpadIn << [176,127,110]
    LpadIn << [176,0,110]
    LpadOut << {name:'reset'}
  end
  
  MainPage = Page.new('MainPage') do
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
