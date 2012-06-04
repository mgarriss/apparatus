module Apparatus
  class StateTimer
    include Logger
    
    def initialize(bind_to,time,key,meth,*args)
      @bind_to = bind_to
      # def bind_to.timers
      #   @timers ||= {}
      # end
      @key = key
      @done = false
      @signature = EM.add_timer(time) do
        begin
          bind_to.send(meth,*args)
        ensure
          cancel
        end
      end
      bind_to.timers[key] = self
    end
    
    def cancel
      unless @done
        EM.cancel_timer(@signature) rescue nil
        @bind_to.timers[@key] = nil
      end
    ensure
      @done = true
    end
    
    def done?
      @done
    end
  end
  
  module Timed
    include Logger
    def add_timer(*args)
      Apparatus::StateTimer.new(self,*args)
    end
    
    def timer_done?(key)
      if timers[key]
        timers[key].done?
      else
        true
      end
    end
    
    def cancel_timer(key)
      (self.timers[key].cancel rescue nil) unless timer_done?(key)
    end
    
    def timers
      @timers ||= {}
    end
  end
end
