module Apparatus
  module App
    class Output < MIDI::Output
      def self.find(port_name)
        Device.all_by_type(App)[:output].find do |device|
          device.name == port_name
        end or error("#{port_name} input port not available")
      end
      
      def react_to(obj)
        case obj[:name]
        when 'on' then object_out([ 144, obj[:pitch], obj[:velocity] ])
        when 'off' then object_out([ 128, obj[:pitch], (obj[:velocity] || 0) ])
        when 'cc' then object_out([ 176, obj[:value], obj[:number] ])
        else
          $stderr.puts "unknown App::Output message name: #{obj.inspect}"
        end
      end
    end
  end
end
