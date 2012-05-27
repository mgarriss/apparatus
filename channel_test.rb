require 'rubygems'
require 'eventmachine'
require 'em/channel'

module Foo
  def receive_data(data)
    puts 'in receive_data'
  end
end

EM::run do
  # input = EM::Channel.new
  output = EM::Channel.new
  
  # input_sid = input.subscribe do |msg|
  #  output << [:got, msg]
  # end
  
  p output.pop
  
  sleep 10
  output.push('hello world')
  
  sleep 10
  output.push('hello world2')
  
  # input.unsubscribe(input_sid)
  # input.unsubscribe(input_sid)
end
