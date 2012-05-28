module Apparatus
  module App
    class Input < MIDI::Input
      def self.find(port_name)
        all_by_type(App)[:input].find do |device|
          device.name == port_name
        end
      end
    end
  end
end
