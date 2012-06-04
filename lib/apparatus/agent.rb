require 'java'
require 'eventmachine'
require 'em/channel'
require 'em/connection'

# java_import java.util.concurrent.Executors
# $executors = Executors.newCachedThreadPool

module Apparatus
  class Agent
    include Logger
    extend Logger
    
    include Timed
    
    attr_accessor :name
    attr_reader :channel
    
    def initialize(name = self.class.to_s)
      super()
      @name = name
      @channel = EM::Channel.new
      child_init if respond_to?(:child_init)
      generate if respond_to?(:generate)
    end
    
    def on_activate(&ex)
      @on_activate = ex
    end
    
    def on_deactivate(&ex)
      @on_deactivate = ex
    end
    
    def <<(rhs)
      if rhs.kind_of? Agent
        attach(rhs)
      else
        object_in(rhs)
      end
      rhs
    end
    
    def >>(rhs)
      rhs.attach(self)
      rhs
    end
    
    def attach(agent)
      info agent
      agent.channel.subscribe do |obj|
        object_in obj
      end
      agent
    end
    
    def object_in(obj)
      if filter(obj)
        info obj
        _react_to(obj)
      end
    end
    
    # the end point
    def object_out(obj)
      info obj
      if block_given?
        yield
      else
        @channel.push(obj)
      end
    end
    
    def _react_to(obj)
      react_to(@obj = obj)
    end
    
    # override me
    def react_to(obj)
      object_out(obj)
    end
    
    # override me
    def filter(obj)
      true
    end
    
    def inspect
      @name.to_s
    end
  end
end
