require 'rubygems'
require 'java'
require 'midi'
# require 'jretlang'
# require 'midi-eye'

class Object
  def my_methods
    methods - Object.instance_methods
  end
end

#require 'akka'

require 'eventmachine'

module Apparatus
  
  class MIDIInput
    def initialize(pipe)
      @pipe = pipe
      @input = UniMIDI::Input.gets # all.find{|i| i.name == 'Launchpad'}
      @listener = MIDIEye::Listener.new(@input)
    end
    
    def run
      @listener.listen_for(class:[MIDIMessage::NoteOn,MIDIMessage::NoteOff]) do |e|
         begin
          # puts [e.value / 16, e.value % 16, e.velocity == 127 ? 1 : 0].pack('CCC')
          @pipe.puts e[:message].data.join(',')
        rescue => e
          p e
        end
      end
      @listener.run
    end
  end
  
  class BasicInput < EM::Connection
    def notify_readable # (data)
      puts @io.readline
    end
  end
  
end

$pipe_read, $pipe_write = IO.pipe

t = Thread.new do
  midi_input = Apparatus::MIDIInput.new($pipe_write)
  midi_input.run
end

EventMachine.run {
  conn = EventMachine.watch($pipe_read, Apparatus::BasicInput)
  conn.notify_readable = true
}

t.join

#########################################################################

# include Apparatus

# $fiber = JRL::Fiber.new
# $channel = JRL::Channel.new

# $channel.subscribe_on_fiber($fiber) do |event|
#   p event
# end

# $input = MIDIInput.new($channel)

# $fiber.execute do
#   puts 'HERE'
#   $input.run
# end

# $fiber.start
# $fiber.join
