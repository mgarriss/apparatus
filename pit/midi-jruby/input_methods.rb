module MIDIJRuby
  module InputMethods
    # [ { :data => "904060", :timestamp => 904 } ]
    # def gets_s
    #   msgs = gets
    #   msgs.each { |msg| msg[:data] = numeric_bytes_to_hex_string(msg[:data]) }
    #   msgs  
    # end
    # alias_method :gets_bytestr, :gets_s
    # alias_method :gets_hex, :gets_s

    def close
      # @listener.kill
      @transmitter.close
      @device.close
      @enabled = false
    end
    
    def now
      ((Time.now.to_f - @start_time) * 1000)
    end
    
    # give a message its timestamp and package it in a Hash
    def get_message_formatted(raw, time) 
      { :data => raw, :timestamp => time }
    end
    
    def numeric_bytes_to_hex_string(bytes)
      bytes.map { |b| s = b.to_s(16).upcase; b < 16 ? s = "0" + s : s; s }.join
    end   
    
    def enable(options = {}, &block)
      @device.open
      @transmitter = @device.get_transmitter
      @transmitter.set_receiver(InputReceiver.new)
      initialize_buffer
      @start_time = Time.now.to_f
      @enabled = true
      if block_given?
        begin
          block.call(self)
        ensure
          close
        end
      else
        self
      end
    end
    
    alias_method :open, :enable
    alias_method :start, :enable
  end
end
