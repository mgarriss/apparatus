module Apparatus
  module App
    class Input < MIDI::Input
      def self.find(port_name)
        Device.all_by_type(App)[:input].find do |device|
          device.name == port_name
        end
      end
      
      def react_to(obj)
        return unless obj.size == 3
        case obj.first
        when 144
          if obj.last == 0
            object_out ['off',obj[1],obj[2]]
          else
            object_out ['on',obj[1],obj[2]]
          end
        when 176
          object_out ['cc',obj[2],obj[1]]
        end
      end
    end
  end
end
