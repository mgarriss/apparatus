require 'spec_helper'
require 'apparatus/action_builder'

include Apparatus

=begin
   could receive 
     :tap,     col, row, stamp
     :press,   col, row, stamp
     :release, col, row, stamp

   could send
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

describe ActionBuilder do
  before :all do
    @input = EM::Channel.new
    @output = double 'output'
    @event_builder = ActionBuilder.new(@input,@output)
  end
end
