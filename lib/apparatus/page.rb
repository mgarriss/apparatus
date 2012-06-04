module Apparatus
  class Page < Control
    include Helpers

    def initialize(name,&block) 
      super(name)
      LpadEvent >> self >> LpadEffect 
      @activated = false
      @controls = {}
      @state = {}
      instance_eval(&block)
    end
    
    def on?(loc)
      !!@state[loc]
    end
    
    def off?(loc)
      @state[loc].nil?
    end
    
    def activated?
      @activated
    end
    
    def to_activate(&ex)
      @to_activate = ex
    end
    
    def to_deactivate(&ex)
      @to_deactivate = ex
    end
    
    def on_activate(&ex)
      @on_activate = ex
    end
    
    def on_deactivate(&ex)
      @on_deactivate = ex
    end
    
    def deactivate!
      @activated = false
      @on_deactivate.call if @on_deactivate
    end
    
    def activate!
      @activated = true
      @on_activate.call if @on_activate
    end
    
    def react_to(obj)
      if activated? && @to_deactivate && @to_deactivate.call(obj)
        deactivate!
      elsif !activated? && @to_activate &&  @to_activate.call(obj)
        activate!
      elsif activated?
        store_state(obj)
        super obj
      end
    end
    
    def add_control(name, klass, *args)
      @controls[name] = klass.new(name,*args)
    end
    
    def store_state(obj)
      obj = obj.dup
      key = {col:obj.delete(:col),row:obj.delete(:row)}
      if obj[:name] == 'off'
        @state[key] = nil
      else
        @state[key] = obj
      end
    end
  end
end
