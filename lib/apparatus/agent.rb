require 'java'
require 'eventmachine'
require 'em/channel'
require 'em/connection'

java_import java.util.concurrent.Executors

module Apparatus
  class Agent
    module Attachment
      def receive_data(data)
        @agent.object_in Marshal.load(data)
      end
    end
    
    def self.spin_off
      Pool.submit do
        begin
          yield
        rescue => e
          $stderr.puts 'Apparatus ERROR'
          $stderr.puts inspect
          $stderr.puts e.class
          $stderr.puts e.message
          $stderr.puts e.backtrace
        end
      end
    end

    ReactorThread = Thread.start do
      EM.run do
      end
    end
    
    Pool = Executors.newCachedThreadPool    
    
    def self.start(*args)
      new(*args).start
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
    attr_reader :name
    attr_reader :in_in,:in_out,:out_in,:out_out
    
    attr_accessor :attached_to_output, :attached_to_input
    
    def initialize(name = self.class.to_s)
      @name, @threaded = name, false
      reset
    end
    
    def reset
      @attached_to_input, @attached_to_output = false, false
      @received, @produced = nil, nil
      @in_in.close if @in_in.respond_to?(:close)
      @in_out.close if @in_out.respond_to?(:close)
      @out_in
      @out_out = IO.pipe
      @in_in, @in_out = IO.pipe
      @out_in, @out_out = IO.pipe
      @alive = true
      stop
      @generator = Agent.spin_off { generate } if respond_to?(:generate)
    end
    
    def stop
      @executor.stop if @executor.respond_to?(:start)
      @generator.stop if @executor.respond_to?(:start)
    end
    
    def kill
      @received = @produced = @alive = nil
      @executor.kill if @executor.respond_to?(:kill)
      @generator.kill if @executor.respond_to?(:kill)
      close
      def self.<<(*args) nil; end
      def self.>>(*args) nil; end
      def self.attach(*args) nil; end
      def self.object_in(*args) nil; end
      def self.object_out(*args) nil; end
      def self.reset(*args) nil; end
    end

    # override me
    def close
    end
    
    def start
      @threaded = true
      @executor.start if @executor.respond_to?(:start)
      @generator.start if @executor.respond_to?(:start)
      self
    end
    
    def alive?
      @alive
    end
    
    def threaded?
      @threaded
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
      @attached_to_input = true
      agent.attached_to_output = true
      EM.next_tick do
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
        @received = obj
        _react_to(obj)
      end
    end
    
    # the end point
    def object_out(obj)
      @channel.push(obj) if @channel
      if @attached_to_output
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
    
    def _react_to(obj)
      if @attached_to_output
        if @threaded
          @executor = Agent.spin_off { react_to(obj) }
        else
          react_to(obj)
        end
      end
    end
  end
end
