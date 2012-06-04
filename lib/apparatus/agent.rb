require 'java'
require 'eventmachine'
require 'em/channel'
require 'em/connection'

# java_import java.util.concurrent.Executors
# $executors = Executors.newCachedThreadPool

module Apparatus
  class Agent
    module Attachment
      def receive_data(data)
        EM.next_tick do
          @agent.object_in Marshal.load(data)
        end
      end
    end
    
    include Logger
    extend Logger
    
    include Timed
    
    def self.attach(rhs)
      new.attach(rhs)
    end
    
    def self.<<(rhs)
      new << rhs
    end
    
    def self.>>(rhs)
      new >> rhs
    end
    
    def received
      @received.pop
    end
    
    def produced
      @produced.pop
    end
    
    attr_accessor :name
    attr_reader :production
    attr_reader :in_in,:in_out,:out_in,:out_out
    
    attr_accessor :attached_to_output, :attached_to_input
    
    state_machine :state, initial: :deactivated do
      event :deactivate! do
        transition any => :deactivated
      end
      
      event :activate! do
        transition any => :activated
      end
      
      state :deactivated do
        def should_activate?(event=nil)
          @to_activate.call(event)
        end
      
        def should_deactivate?(event=nil)
          true
        end
      end
      
      # def deactivate!
      #   @activated = false
      #   @on_deactivate.call if @on_deactivate
      # end
      
      # def activate!
      #   @activated = true
      #   @on_activate.call if @on_activate
      # end
    end
    
    def initialize(name = self.class.to_s)
      super()
      @name = name
      @received, @produced = EM::Queue.new, EM::Queue.new
      @production = Array.new(8) do Hash.new end
      @attached_to_input, @attached_to_output = false, false
      @in_in, @in_out = IO.pipe
      @out_in, @out_out = IO.pipe
      child_init if respond_to?(:child_init)
      generate if respond_to?(:generate)
    end
    
    def on_activate(&ex)
      @on_activate = ex
    end
    
    def on_deactivate(&ex)
      @on_deactivate = ex
    end
    
    def clear
      @received, @produced = nil, nil
      @production = Array.new(8) do Hash.new end
    end
    
    def <<(rhs)
      rhs = rhs.new(rhs.to_s) if rhs.respond_to?(:new)
      if rhs.kind_of? Agent
        attach(rhs)
      else
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
        activate!
        agent.activate!
        EM.attach(agent.out_in,Attachment) do |conn|
          conn.instance_variable_set(:@agent, self)
          true
        end
      end
      agent
    end
    
    def broadcast_to(agents)
      @channel ||= EM::Channel.new
      agents.each do |agent|
        @channel.subscribe agent.method(:object_in)
      end
    end

    
    ### INPUT and OUPUT 

    def object_in(obj)
      if filter(obj)
        @received = obj
        info obj
        _react_to(obj)
      end
    end
    
    # the end point
    def object_out(obj)
      @channel.push(obj) if @channel
      @production << obj
      @production.shift
      @produced = obj
      info obj
      if block_given?
        yield
      else
        @out_out << Marshal.dump(obj)
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
