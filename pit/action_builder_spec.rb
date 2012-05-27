require 'spec_helper'
require 'apparatus/mode'

include Apparatus

=begin
   could receive 
     :tap,     col, row, stamp
     :press,   col, row, stamp
     :release, col, row, stamp

   could send
     :tap,     col0, row0, stamp
     :press,   col0, row0, stamp
     :release, col0, row0, stamp
     :roll     col0, row0,  col1, row1, stamp
     :hand,          col,  row,   size, stamp
=end

describe ActionBuilder do
  before :all do
    @input = EM::Channel.new
    @output = double 'output'
    @event_builder = ActionBuilder.new(@input,@output)
  end
end
