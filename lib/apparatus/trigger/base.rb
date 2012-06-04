module Apparatus
  class Trigger < Agent
    def intialize(page,&on_match)
      super(name)
      @on_match = on_match
      @page = page
    end

    def react_to(obj)
      on_match = @on_match
      @page.instance_eval do
        on_match.call(obj)
      end
    end
    
    # child class overrides filter only
  end
end
