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
    
    module Attachment
      def receive_data(data)
        EM.next_tick do
          @agent.object_in Marshal.load(data)
        end
      end
    end
    
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
    attr_accessor :name
    attr_reader :production
    attr_reader :in_in,:in_out,:out_in,:out_out
    
    attr_accessor :attached_to_output, :attached_to_input
    
    def initialize(name = self.class.to_s)
      @name = name
      @received, @produced = nil, nil
      @production = Array.new(8) do Hash.new end
      @attached_to_input, @attached_to_output = false, false
      @in_in, @in_out = IO.pipe
      @out_in, @out_out = IO.pipe
      child_init if respond_to?(:child_init)
      #Apparatus.spin_off do
        generate
      #end if respond_to?(:generate)
    end
    
    def generate
    end
    
    def clear
      @received, @produced = nil, nil
      @production = Array.new(8) do Hash.new end
    end
    
    def attached_to_input?
      @attached_to_input
    end
    
    def attached_to_output?
      @attached_to_output
    end
    
    def <<(rhs)
      rhs = rhs.new(rhs.to_s) if rhs.respond_to?(:new)
      if rhs.kind_of? Agent
        attach(rhs)
      else
        @attached_to_input = true
        object_in(rhs)
      end
      rhs
    end
    
    def >>(rhs)
      if rhs.kind_of? Array
        broadcast_to(rhs)
      else
        rhs = rhs.new(rhs.to_s) if rhs.respond_to?(:new)
        rhs.attach(self)
      end
      rhs
    end
    
    def attach(agent)
      EM.next_tick do
        @attached_to_input = true
        agent.attached_to_output = true
        EM.attach(agent.out_in,Attachment) do |conn|
          conn.instance_variable_set(:@agent, self)
          true
        end
      end
      agent
    end
    
    def broadcast_to(agents)
      @channel ||= EM::Channel.new
      @attached_to_output = true
      agents.each do |agent|
        agent.attached_to_input = true
        @channel.subscribe agent.method(:object_in)
      end
    end

    
    ### INPUT and OUPUT 

    def object_in(obj)
      if @attached_to_input
        if filter(obj)
          @received = obj
          _react_to(obj)
        end
      end
    end
    
    # the end point
    def object_out(obj)
      @channel.push(obj) if @channel
      if @attached_to_output
        @production << obj
        @production.shift
        @produced = obj
        if block_given?
          yield
        else
          @out_out << Marshal.dump(obj)
        end
      end
    end
    
    # override me
    def react_to(obj)
      object_out(obj)
    end
    
    # override me
    def filter(obj)
      true
    end
    
    def _react_to(obj)
      react_to(@obj = obj) if @attached_to_output
    end
  end
end
