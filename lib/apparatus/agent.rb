require 'java'
require 'eventmachine'
require 'em/channel'
require 'em/connection'

java_import java.util.concurrent.Executors

module Apparatus
  class Agent
    module Attachment
      def receive_data(data)
        @agent.react_to_data data
      end
    end
    
    ReactorThread = Thread.start do
      EM.run do
      end
    end
    
    Pool = Executors.newCachedThreadPool    
    
    def self.attach(rhs)
      new.attach(rhs)
    end
    
    def self.<<(rhs)
      new << rhs
    end
    
    def self.>>(rhs)
      new >> rhs
    end
    
    attr_reader :received, :produced
    attr_reader :name
    attr_reader :in_in,:in_out,:out_in,:out_out
    
    def initialize(name = nil)
      @name = name
      @in_in, @in_out = IO.pipe
      @out_in, @out_out = IO.pipe
      if respond_to?(:generate)
        Pool.submit do
          generate
        end
      end
    end
    
    def <<(rhs)
      rhs = rhs.new(rhs.to_s) if rhs.respond_to?(:new)
      if rhs.kind_of? Agent
        attach(rhs)
      else
        react_to_object(rhs)
      end
      rhs
    end
    
    def >>(rhs)
      rhs = rhs.new(rhs.to_s) if rhs.respond_to?(:new)
      rhs.attach(self)
      rhs
    end
    
    def attach(agent)
      EM.next_tick do
        EM.attach(agent.out_in,Attachment) do |conn|
          conn.instance_variable_set(:@agent, self)
          true
        end
      end
      agent
    end
    
    # override me
    def react_to(obj)
      object_out(obj)
    end

    # the start point
    def object_in(obj)
      @received = obj
      react_to(obj)
    end
    
    # the end point
    def object_out(obj)
      @produced = Marshal.dump(obj)
      @out_out << @produced
    end
    
    def clear
      @received = nil
    end

    private
    
    def react_to_data(data)
      Pool.submit do
        object_in Marshal.load(data)
      end
    end
    
    def react_to_object(obj)
      Pool.submit do
        object_in obj
      end
    end
  end
end
