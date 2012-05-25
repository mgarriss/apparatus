require "lpad.server/version"
require 'midi'

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
