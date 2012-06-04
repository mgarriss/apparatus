module Apparatus
  module Lpad
    class Event < Agent
      include Apparatus::Helpers
      
      attr_accessor :tap_threshold
      
      def child_init
        @tap_threshold = 0.1
      end
      
      def react_to(obj)
        case obj.delete(:name)
        when 'on'
          add_timer(self.tap_threshold,
                    obj,
                    :object_out,
                    obj.merge({name:'hold'}))
        when 'off'
          unless timer_done?(obj)
            cancel_timer(obj)
            object_out obj.merge({name:'tap'})
          else
            object_out obj.merge({name:'release'})
          end
        end
      end
    end
  end
end
