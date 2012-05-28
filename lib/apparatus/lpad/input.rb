module Apparatus
  module Lpad
    class Input < MIDI::Input
      
      def self.find(port_name)
        all_by_type(Lpad)[:input].find do |device|
          device.name == port_name
        end
      end
      
      def generate
        loop do
          @midiin.gets.each do |data|
            here
            react_to data[:data]
          end
        end
      end
      
      def react_to(midi)
        here midi
        return unless midi.size == 3
        n, p, v = midi
        object_out({name:(v == 127 ? 'on' : 'off'),
                     col:(p % 16),row:(p / 16),
                     time:timestamp()}) if n == 144
        
      end
    end
  end
end
