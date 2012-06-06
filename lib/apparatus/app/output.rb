module Apparatus
  module App
    class Output < MIDI::Output
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
