require 'spec_helper'
require 'apparatus/page'

include Apparatus

=begin
  - Page is the hub of Apparatus, it ties together the input and
    output of both the launchpad and an external MIDI device
  - has an input channel tied to an ActionBuilder
  - has many LaunchpadTriggers tied to the page's ActionBuilder
  - has many DeviceTriggers tied to the page's Device channel
  - has an output channel (probably a Apparatus::Mode)
  - triggers are 'named' and report themselves on a page's
       internal input channel
  - has many Effects that listen on an internal Page channel
  - on_state_change() method called whenever there is a
         new Trigger message
    - here it could run it's Effects
      - an Effect runs is Notifications
        - a Notification is a collection of timed MIDIFrames 
           - a MIDIFrame is a burst of MIDI messages to a MIDI
                 device
           - a MIDIFrame might be passed args on update
           - a examples MIDIFrame could be a Bar which know's
                 where it is on the Launchpad and what color it
                 needs to be and what level it should be at, etc    
        - an Effect runs it's Feedbacks
           - a Feedback is a collection of LaunchpadFrames
           sends MIDI back to the Lauchpad and 
              - Frame is 
             publishes it's state changes on a channel
      - a Feedback reports the change in
      - a Feedback 
      - a Notification is as MIDI script out to a MIDI device
      - a Page can also be subclassed
          - it implements the on_state_change
      - a child class may want to be a state_machine (just an idea)
   a Page updates an internal "state of the launchpad"
   a Page  
    
=end

describe Page do
end
