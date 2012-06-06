module Apparatus
  module App
    class Input < MIDI::Input
      def filter(obj)
        obj.size == 3 and
          [144,176,128].include?(obj.first)
      end
      
      def react_to(obj)
        case obj.first
        when 144
          if obj.last == 0
            object_out({name:'off',pitch:obj[1],velocity:obj[2]})
          else
            object_out({name:'on',pitch:obj[1],velocity:obj[2]})
          end
        when 176
          object_out({name:'cc',number:obj[2],value:obj[1]})
        when 128
          object_out({name:'off',pitch:obj[1],velocity:obj[2]})
        else
          error "unknown first byte :#{obj.first}"
        end
      end
    end
  end
end
