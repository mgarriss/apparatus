Apparatus.start

module Apparatus
  LpadOut = Lpad::Output.find('Launchpad').start
  LpadIn = Lpad::Input.find('Launchpad').start
  AppOut = App::Output.find('from Apparatus').start
  AppIn = App::Input.find('to Apparatus').start
end
