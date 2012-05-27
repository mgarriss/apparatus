module Apparatus
  
  class Agent
    attr_reader :output
    
    def initialize(input,output) #,&on_input)
      # @input, @output, @on_input = input, output, on_input
      @input, @output = input, output
      @input.attach do |message|
        yield self, message
      end
    end
  end
  
end
