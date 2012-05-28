module MIDIJRuby
  module InputBufferMethods
    # def initialize_buffer
    #   @buffer = []
    #   @pointer = 0
    #   def @buffer.clear
    #     @pointer = 0
    #     super        
    #   end
    # end
    
    # def queued_messages
    #   @buffer.slice(@pointer, @buffer.length - @pointer)
    # end
    
    # def queued_messages?
    #   @pointer < @buffer.length
    # end
    
    # launch a background thread that collects messages
    # def spawn_listener!
    #   @listener = Thread.fork do
    #     begin
    #       while true          
    #         while (msgs = poll_system_buffer).empty?
    #           sleep(1.0/1000)
    #         end
    #         populate_local_buffer(msgs) unless msgs.empty?
    #       end
    #     rescue => e
    #       here e
    #     end
    #   end
    # end
    
    # def poll_system_buffer
    #   @transmitter.get_receiver.read
    # end
    
    # def populate_local_buffer(msgs)
    #   msgs.each { |raw| @buffer << get_message_formatted(raw, now) unless raw.nil? }
    # end
  end
end
