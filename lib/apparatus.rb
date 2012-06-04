require "apparatus/version"

require 'java'
require 'eventmachine'

$logout = File.open('./log/apparatus.log', 'w')

require 'apparatus/controller'
require 'apparatus/core_ext'
require 'apparatus/helpers'
require 'apparatus/state_timer'
require 'apparatus/agent'
require 'apparatus/midi'
require 'apparatus/lpad'
require 'apparatus/app'
require 'apparatus/effects'
require 'apparatus/triggers'
require 'apparatus/controls'
require 'apparatus/page'

# require 'apparatus/standard_agents'
