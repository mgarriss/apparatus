require 'spec_helper'

describe Agent, :focus do
  it 'has an input and an output pipe' do
    @thread = Thread.start(@pipe) do |pipe|
      begin
        EM.run do
          @input = Pipe.new
          @output = Pipe.new
          @agent = Agent.new(@input,@output) do |agent,input|
            agent.output << input
          end
        end
      rescue => e
        puts e.message
      end
    end
    sleep 1
    @input << 'dude'
    sleep 1
    @thread.kill
  end
end
