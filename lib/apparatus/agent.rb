require 'java'
require 'eventmachine'
require 'em/channel'
require 'em/connection'

module Apparatus
  
  module Attachment
    def receive_data(data)
      p @agent.object_id
      @agent.on_input data
    end
  end
  
  class Agent
    def self.listen_to(agent, *args, &on_input)
      new(*args,&on_input).connect(agent)
    end
    
    def initialize(*args, &on_input)
      @input = IO.pipe
      @output = IO.pipe
      @on_input = on_input
      EM::attach(@input.first,Attachment) do |conn|
        conn.instance_variable_set(:@agent, self)
        true
      end
    end
    
    def output
      @output.first
    end
    
    def connect(agent)
      EM::attach(output,Attachment) do |conn|
        conn.instance_variable_set(:@agent, agent)
        true
      end
      self
    end
    
    def on_input(data)
      @on_input.call(self,data)
    end
    
    def send(obj)
      @output.last << Marshal.dump(obj)
      @output.last.flush
      @output
    end
    
    def <<(rhs)
      # p rhs
      # p Marshal.dump(rhs)
      @input.last << Marshal.dump(rhs)
      @input.last.flush
      @input.last
    end
  end
  
end
