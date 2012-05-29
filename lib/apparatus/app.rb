require 'apparatus/app/input'
require 'apparatus/app/output'

module Apparatus
  AppOut = App::Output.find('from Apparatus').start
  AppIn = App::Input.find('to Apparatus').start
end
