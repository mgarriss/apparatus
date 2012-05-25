require 'spec_helper'
require 'apparatus/trigger'

include Apparatus

=begin
  trigger can match:
     :tap,           col0, row0
     :press,         col0, row0
     :release,       col0, row0

     :roll           col0, row0,  col1, row1

     :span_tap,      col0, row0,  col1, row1
     :span_press,    col0, row0,  col1, row1
     :span_release,  col0, row0,  col1, row1

     :chord_tap,     col0, row0,  col1, row1,  col2, row2
     :chord_press,   col0, row0,  col1, row1,  col2, rol2
     :chord_release, col0, row0,  col1, row1,  col2, rol2

     :hand,          col,  row,   size
=end

describe Trigger do
  before :all do
    @input = EM::Channel.new
    @output = double
  end
  
  it 'calls a given block on a match' do
    action = [:tap,0,0]
    @trigger = Trigger.new(@input,@output,action) do |out,act|
      output.publish act
    end
    @output.should_receive(:publish).with(action)
    @input.publish [:tap,0,0]
  end
end
