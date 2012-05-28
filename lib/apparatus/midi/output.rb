module Apparatus
  module MIDI
    class Output < Agent
      import javax.sound.midi.MidiSystem
      import javax.sound.midi.ShortMessage
      import javax.sound.midi.SysexMessage
      
      include DeviceInstance
      extend DeviceClass
      
      def self.device_args
        [self, :output]
      end
      
      def self.find(port_name)
        all_by_type(MIDI)[:output].find do |device|
          device.name == port_name
        end
      end
      
      def initialize(*args)
        init_device(*args)
        @device.open
        super(@name)
      end
      
      # close this output
      def close
        @device.close
      end
      
      def react_to(*byte_array)
        puts(*byte_array)
      end

      private
      
      
      # sends a MIDI message comprised of a String of hex digits 
      def puts_s(data)
        data = data.dup
        output = []
        until (str = data.slice!(0,2)).eql?("")
          output << str.hex
        end
        puts_bytes(*output)
      end
      alias_method :puts_bytestr, :puts_s
      alias_method :puts_hex, :puts_s

      # send a MIDI message of an indeterminant type
      def puts(*a)
        case a.first
        when Array then puts_bytes(*a.first)
        when Numeric then puts_bytes(*a)
        when String then puts_bytestr(*a)
        end
      end
      alias_method :write, :puts
      
      # sends a MIDI messages comprised of Numeric bytes 
      def puts_bytes(*data)
        @produced = data
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


