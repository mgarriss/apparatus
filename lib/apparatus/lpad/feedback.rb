module Apparatus
  module Lpad
    class Feedback < Agent
      def filter(obj)
        %w|tap hold release|.include?(obj[:name])
      end
      
      def react_to(obj)
        obj = obj.dup
        if obj[:name] == 'hold'
          obj[:name] = 'amber'
          object_out obj
        elsif obj[:name] == 'tap'
          if obj[:col] == 8
            case obj[:row]
            when 7 then object_out(name:'reset')
            when 6 then animate
            end
          else
            obj[:name] = 'green'
            obj[:wait] = 0.3
            obj[:then] = {name:'yellow',dc:-1,dr:+1}
            object_out obj
          end
        elsif obj[:name] == 'release'
          obj[:name] = 'red'
          object_out obj
        end
      end
      
      def animate
        object_out \
          frames:[
            {name:'amber',col:0,row:0,wait:1.0},
            {name:'amber',col:1,row:0,wait:1.0},
            {name:'amber',col:2,row:1,wait:1.0},
            {name:'amber',col:1,row:1,wait:1.0},
            {name:'amber',col:1,row:2,wait:1.0},
            {name:'amber',col:1,row:3,wait:1.0},
            {name:'amber',col:1,row:4,wait:1.0},
            {name:'amber',col:2,row:5,wait:1.0},
            {name:'amber',col:3,row:5,wait:1.0}],
          rate:0.2
      end
    end
  end
end
