#!/usr/local/Cellar/ruby/1.9.3-p125/bin/ruby

require 'rubygems'
require 'eventmachine'
require 'midi'
# require 'lpad.server'

require 'java'
@count = java.util.concurrent.atomic.AtomicInteger.new

require 'jretlang'

fiber = JRL::Fiber.new
channel = JRL::Channel.new
fiber.start

channel.subscribe_on_fiber(fiber) do |msg|
  puts msg
end

channel.publish "Hello"

$output = UniMIDI::Output.use(:first)
$count = 0

module LpadServer
  
  def post_init
    puts "-- someone connected to the echo server!"
  end

  def receive_data data
    $count += 1
    $output.puts 144, 0, ($count % 128)
  end
end

EM::run do
  begin
    EM::open_datagram_socket '127.0.0.1', 4427, LpadServer
    puts 'running echo server on 4427'
  rescue => e
    p e
  end
end

__END__

class Server
  attr_accessor :connections
  
  def initialize
    @connections = []
  end
  
  def start
    @signature = EventMachine.start_server('0.0.0.0', 3000, Connection) do |con|
      con.server = self
    end
  end
  
  def stop
    EventMachine.stop_server(@signature)
    
    unless wait_for_connections_and_stop
      # Still some connections running, schedule a check later
      EventMachine.add_periodic_timer(1) { wait_for_connections_and_stop }
    end
  end

  def wait_for_connections_and_stop
    if @connections.empty?
      EventMachine.stop
      true
    else
      puts "Waiting for #{@connections.size} connection(s) to finish ..."
      false
    end
  end
end

class Connection < EventMachine::Connection
  attr_accessor :server
  
  def unbind
    server.connections.delete(self)
  end
end

EventMachine::run {
  s = Server.new
  s.start
  puts "New server listening"
}
