require 'apparatus'
include Apparatus

Apparatus.start do
  require 'apparatus/standard_agents'
  LpadEvent >> FB >> LpadEffect
end


