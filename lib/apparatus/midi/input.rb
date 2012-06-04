module Apparatus    
  module MIDI
    class Input < Agent
      include Device
      
      def self.device_args
        [self, :output]
      end
      
      def self.find(port_name)
        Device.all_by_type(MIDI)[:input].find do |device|
          device.name == port_name
        end or error("#{port_name} input port not available")
      end
      
      def initialize(*args)
        init_device(*args)
        super(@name)
        @device.open
        @transmitter = @device.get_transmitter
        @receiver = MIDIReceiver.new
        @transmitter.set_receiver @receiver
        @attached_to_input = true
      end

      def generate
        EM.next_tick do
          EM.attach(@receiver.io_in,Agent::Attachment) do |conn|
            conn.instance_variable_set(:@agent,self)
            true
          end
        end
      end
      
      def close
        @transmitter.close
        @device.close
      end
      
      # give a message its timestamp and package it in a Hash
      def get_message_formatted(raw, time) 
        { :data => raw, :timestamp => time }
      end
      
      def numeric_bytes_to_hex_string(bytes)
        bytes.map { |b| s = b.to_s(16).upcase; b < 16 ? s = "0" + s : s; s }.join
      end   
    end
  end
end
