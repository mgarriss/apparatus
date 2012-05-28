module Apparatus    
  module MIDI
    module InputHandler
      def receive_data(data)
        here.receive_data(data)
      end
    end
    
    class Input < Agent
      import javax.sound.midi.MidiSystem
      
      include DeviceInstance
      extend DeviceClass
      
      def self.device_args
        [self, :output]
      end
      
      def self.find(port_name)
        all_by_type(MIDI)[:input].find do |device|
          device.name == port_name
        end
      end
      
      def initialize(*args)
        init_device(*args)
        super(@name)
        @device.open
        @transmitter = @device.get_transmitter
        @transmitter.set_receiver(MIDIReceiver.new)
      end
      
      def generate
        EM.next_tick do
          here.generate
          EM.attach(@transmitter.get_receiver.io_in,MIDI::InputHandler) do |conn|
            conn.instance_variable_set(:@agent,self)
            true
          end
        end
      end
      
      def react_to(midi)
        return unless midi.size == 3
        n, p, v = midi
        object_out({name:(v == 127 ? 'on' : 'off'),
                     col:(p % 16),row:(p / 16),
                     time:timestamp()}) if n == 144
        
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
