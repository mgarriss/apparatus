require 'spec_helper'

module Foo
  def receive_data(data)
    puts "size was: #{Marshal.load(data).inspect}"
  end
end

describe Agent do
  it 'works' do
    @thread = Thread.start(@agent) do |agent|
      begin
        EM.run do
          @agent = Agent.new do |this,data|
            this.send("sending through")
          end
          
          Agent.listen_to(@agent) do |this,data|
            puts 'HERE'
          end
          EM.attach(@agent.output,Foo)
        end
      rescue => e
        puts e.class
        puts e.message
      end
    end
    
    sleep 1
    
    @agent << 'a string'
    @agent << [:a,4,4.6]
    
    sleep 3
    
    @thread.kill
  end
end
