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
        end
      end
      
      def initialize(*args)
        init_device(*args)
        @device.open
        @transmitter = @device.get_transmitter
        @receiver = MIDIReceiver.new
        @transmitter.set_receiver @receiver
        super(@name)
        @attached_to_input = true
      end

      def generate
        EM.next_tick do
          begin
            EM.attach(@receiver.io_in,Agent::Attachment) do |conn|
              conn.instance_variable_set(:@agent,self)
              true
            end
          rescue => e
            $stderr.puts "Apparatus ERROR"
            $stderr.puts inspect
            $stderr.puts e.class
            $stderr.puts e.message
          end
        end
      end
      
      def timestamp
        Time.now.to_f
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
