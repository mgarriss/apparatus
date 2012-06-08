module Apparatus    
  module MIDI
    class Input < Device
      module Receiver
        def receive_data(data)
          data = Marshal.load(data)
          case data.size
          when 1 then data += [0,0]
          when 2 then data += [0]
          end
          @agent.object_in data
        end
      end
      
      def initialize(device,name)
        super
        @transmitter = @device.get_transmitter
        @receiver = MIDIReceiver.new
        @transmitter.set_receiver @receiver
      end

      def generate
        EM.next_tick do
          EM.attach(@receiver.io_in,Receiver) do |conn|
            conn.instance_variable_set(:@agent,self)
            true
          end
        end
      end
      
      def close
        # super
        # @transmitter.close
      end
    end
  end
end
