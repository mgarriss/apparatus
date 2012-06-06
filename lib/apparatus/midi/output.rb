module Apparatus
  module MIDI
    class Output < Device
      import javax.sound.midi.MidiSystem
      import javax.sound.midi.ShortMessage
      import javax.sound.midi.SysexMessage
      
      def react_to(byte_array)
        object_out byte_array
      end
      
      def object_out(data)
        super(data) do
          if data.first.eql?(0xF0)
            msg = SysexMessage.new
            msg.set_message(data.to_java(:byte), data.length)
          else
            msg = ShortMessage.new
            msg.set_message(*data)
          end
          @device.get_receiver.send(msg, 0)
        end
      end
    end
  end
end


