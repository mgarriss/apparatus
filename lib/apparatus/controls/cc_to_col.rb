module Apparatus
  class CCtoCol < Control
    def initialize(name,opts = {})
      super(name)
      @cc = opts[:cc]
      @col = opts[:col]
    end
  end
end
