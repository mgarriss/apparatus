require 'apparatus/app/input'
require 'apparatus/app/output'

module Apparatus
  AppOut = Lpad::Output.find('from Apparatus')
  AppIn = Lpad::Input.find('to Apparatus')
end
