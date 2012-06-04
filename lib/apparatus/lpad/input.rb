module Apparatus
  module Lpad
    class Input < MIDI::Input
      def self.find(port_name)
        Device.all_by_type(Lpad)[:input].find do |device|
          device.name == port_name
        end or error("#{port_name} input port not available")
      end
      
      def react_to(midi)
        n, p, v = midi
        if [144,128].include?(n)
          p ||= 0
          v ||= 0
          object_out({name:(v == 127 ? 'on' : 'off'),
                       col:(p % 16),row:(p / 16)})
        end
      end
    end
  end
end
