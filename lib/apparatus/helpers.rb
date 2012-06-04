module Apparatus
  module Helpers
    def scene(color,row,args={})
      {name:color,col:8,row:row}.merge(args)
    end
    def left(color,row,args={})
      {name:color,col:0,row:row}.merge(args)
    end
    def right(color,row,args={})
      {name:color,col:7,row:row}.merge(args)
    end
    def top(color,col,args={})
      {name:color,col:col,row:0}.merge(args)
    end
    def bottom(color,col,args={})
      {name:color,col:col,row:7}.merge(args)
    end
    def scene?(row = nil)
      if row.nil?
        @obj[:col] == 8
      else
        @obj[:col] == 8 and @obj[:row] == row
      end
    end
    def tap?
      @obj[:name] == 'tap'
    end
  end
end
