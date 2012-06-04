module Apparatus
  class Control < Agent
    include Apparatus::Helpers

    def initialize(name) 
      super(name)
      @triggers = []
      @effects = {}
    end
    
    def add_trigger(klass,*args,&on_match)
      @triggers.push(klass.new(self, *args, &on_match))
    end
    
    def add_effect(name,klass,*args)
      @effects[name] = klass.new(*args)
    end

    def react_to(obj)
      @triggers.each do |trigger|
        trigger << obj
      end
    end
    
    def clear
    end
  end
end
