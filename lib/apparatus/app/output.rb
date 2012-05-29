module Apparatus
  module App
    class Output < MIDI::Output
      def self.find(port_name)
        Device.all_by_type(App)[:output].find do |device|
          device.name == port_name
        end
      end
      
      def react_to(obj)
        case obj.first
        when 'on' then object_out([ 144, obj[1], obj[2] ])
        when 'off' then object_out([ 144, obj[1], 0 ])
        when 'cc' then object_out([ 176, obj[2], obj[1] ])
        else
          $stderr.puts "unknown App::Output message name: #{obj.inspect}"
        end
      end
    end
  end
end
