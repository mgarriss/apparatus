module Apparatus
  module Lpad
    class Input < MIDI::Input
      def self.find(port_name)
        Device.all_by_type(Lpad)[:input].find do |device|
          device.name == port_name
        end
      end
      
      def react_to(midi)
        return unless midi.size == 3
        n, p, v = midi
        object_out({name:(v == 127 ? 'on' : 'off'),
                     col:(p % 16),row:(p / 16),
                     time:timestamp()})
        
      end
    end
  end
end
