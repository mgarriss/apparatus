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
  
  EM.next_tick do
    User2 = Page.new('User2') do
      to_activate do
        tap? and user2?
      end
      
      to_deactivate do
        tap? and cc? and !user2?
      end
      
      add_effect :flash_on, FlashOn, 'yellow'
      
      add_trigger(CellTapped) do |obj|
        effect!(:flash_on,obj)
      end
    end
  end
  sleep 4
end
