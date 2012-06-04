module Apparatus
  module Lpad
    class Effect < Agent
      include Apparatus::Helpers
      
      def react_to(obj)
        obj = obj.dup
        if obj[:frames]
          rate = obj[:rate] || 0.5
          object_in obj[:frames].shift
          unless obj[:frames].empty?
            add_timer(rate,nil,:object_in,
                      {frames:obj[:frames],rate:rate})
          end
        elsif obj[:wait]
          object_out(obj)
          if obj[:then]
            obj[:then][:row] = obj[:row] unless obj[:then][:row]
            obj[:then][:col] = obj[:col] unless obj[:then][:col]
            obj[:then][:row] = obj[:row] + obj[:then][:dr] if obj[:then][:dr]
            obj[:then][:col] = obj[:col] + obj[:then][:dc] if obj[:then][:dc]
            add_timer(obj[:wait],obj,
                      :object_in,
                      obj[:then])
          else
            add_timer(obj[:wait],obj,
                      :object_out,
                      obj.merge(name:'off'))
          end
        else
          object_out(obj)
        end
      end
    end
  end
end
