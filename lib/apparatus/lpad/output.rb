module Apparatus
  module Lpad
    class Output < MIDI::Output
      def self.find(port_name)
        Device.all_by_type(Lpad)[:output].find do |device|
          device.name == port_name
        end
      end
      
      def react_to(obj)
        case obj[:name]
        when 'on'
          pitch = (obj[:row] * 16) + obj[:col]
          object_out([ 144, pitch, 127 ])
        when 'off'
          pitch = (obj[:row] * 16) + obj[:col]
          object_out([ 128, pitch, 0 ])
        else
          $stderr.puts "unknown App::Output message name: #{obj.inspect}"
        end
      end
    end
  end
end
