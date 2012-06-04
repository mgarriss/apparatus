module Apparatus
  module Lpad
    class Output < MIDI::Output
      def self.find(port_name)
        Device.all_by_type(Lpad)[:output].find do |device|
          device.name == port_name
        end or error("#{port_name} input port not available")
      end
      
      def child_init
        @last_col, @last_row = 0, 0
      end
      
      def react_to(obj)
        obj, pitch = normalize(obj)
        case obj[:name]
        when 'on'
          object_out([ 144, pitch, 127 ])
        when 'off'
          object_out([ 128, pitch, 0 ])
        when 'red'
          if obj[:brightness] == 'low'
            object_out([ 144, pitch, 13 ])
          else
            object_out([ 144, pitch, 15 ])
          end
        when 'green'
          if obj[:brightness] == 'low'
            object_out([ 144, pitch, 28 ])
          else
            object_out([ 144, pitch, 60 ])
          end
        when 'amber'
          if obj[:brightness] == 'low'
            object_out([ 144, pitch, 29 ])
          else
            object_out([ 144, pitch, 63 ])
          end
        when 'yellow'
          object_out([ 144, pitch, 62 ])
        when 'reset'
          object_out([176,0,0])
        else
          error "unknown message name: #{obj.inspect}"
        end
      end
      
      def normalize(obj)
        obj = obj.dup
        if obj[:row]
          if obj[:row] < 0
            obj[:row] = 0
          else
            if obj[:row] > 7
              obj[:row] = 7
            end
          end
        end
        if obj[:col]
          if obj[:col] < 0
            obj[:col] = 0
          else
            obj[:col] = 8 if obj[:col] > 8
          end
        end
        obj[:col] = @last_col if obj[:col].nil?
        obj[:row] = @last_row if obj[:row].nil?
        @last_col,@last_row = obj[:col], obj[:row]
        pitch = (((obj[:row] * 16) + obj[:col]) rescue 0) 
        [obj,pitch]
      end
    end
  end
end
