module MIDIJRuby
  class InputReceiver
    include javax.sound.midi.Receiver
    extend Forwardable
    attr_reader :stream
    
    attr_reader :io_in, :io_out
    
    def initialize()
      @io_in, @io_out = IO.pipe
    end
    
    # def read
    #   to_return = @buf.dup
    #   @buf.clear
    #   to_return
    # end
    
    def send(msg, timestamp = -1)
      puts "send: #{msg}"
      if msg.respond_to?(:get_packed_msg)
        m = msg.get_packed_msg
        @io_out << unpack(m)
      else
        str = String.from_java_bytes(msg.get_data)
        arr = str.unpack("C" * str.length)
        arr.insert(0, msg.get_status)
        @io_out << arr 
      end
    end      
    
    private
    
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

