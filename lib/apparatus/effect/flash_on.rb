module Apparatus
  class FlashOn < Lpad::Effect
    def initialize(color)
      super()
      @color = color
    end
  end
end
