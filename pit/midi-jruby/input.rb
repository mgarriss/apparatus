module MIDIJRuby
  class Input < Apparatus::Agent
    import javax.sound.midi.Transmitter
    include Device
    attr_reader :buffer
    
    include InputMethods
    include InputBufferMethods
    
    def self.first() Device.first(:input) end
    def self.last() Device.last(:input) end
    def self.all() Device.all_by_type[:input] end
    
    # [{ :data => [144, 60, 100], :timestamp => 1024 }]
    def gets
      until queued_messages?
      end
      msgs = queued_messages
      @pointer = @buffer.length
      msgs
    end
    alias_method :read, :gets
  end
end
