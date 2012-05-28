module Apparatus
  module Lpad
    class Output < MIDI::Output
      def self.find(port_name)
        all_by_type(Lpad)[:output].find do |device|
          device.name == port_name
        end
      end
    end
  end
end
