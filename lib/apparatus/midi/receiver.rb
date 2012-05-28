module Apparatus
  class MIDIReceiver
    include javax.sound.midi.Receiver
    extend Forwardable
    attr_reader :stream
    
    attr_reader :io_in, :io_out
    
    def initialize()
      @io_in, @io_out = IO.pipe
    end
    
    def send(msg, timestamp = -1)
      if msg.respond_to?(:get_packed_msg)
        @io_out << Marshal.dump(unpack(msg.get_packed_msg))
      else
        str = String.from_java_bytes(msg.get_data)
        arr = str.unpack("C" * str.length)
        arr.insert(0, msg.get_status)
        @io_out << Marshal.dump(arr)
      end
    end      
    
    def unpack(msg)
      # there's probably a better way of doing this
      o = []
      s = msg.to_s(16)
      s = "0" + s if s.length.divmod(2).last > 0
      while s.length > 0 
        o << s.slice!(0,2).hex
      end
      o.reverse        
    end
  end
end
