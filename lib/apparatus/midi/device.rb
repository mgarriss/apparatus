module Apparatus
  module DeviceInstance
    import javax.sound.midi.MidiDevice
    import javax.sound.midi.MidiEvent
    import javax.sound.midi.Receiver
    
    attr_reader :enabled, :id, :name, :description, :vendor, :type 

    alias_method :enabled?, :enabled
    
    def init_device(id, device, options = {}, &block)
      @name = options[:name]
      @description = options[:description]
      @vendor = options[:vendor]
      @id = id
      @device = device

      # cache the type name so that inspecting the class isn't necessary each time
      @type = self.class.name.split('::').last.downcase.to_sym

      @enabled = false
    end

    def timestamp
      Time.now.to_f
    end
  end
  
  module DeviceClass
    def all_by_type(type)
      available_devices = { :input => [], :output => [] }
      count = -1
      MidiSystem.get_midi_device_info.each do |info|
        device = MidiSystem.get_midi_device(info)
        opts = { :name => info.get_name, 
          :description => info.get_description, 
          :vendor => info.get_vendor }
        available_devices[:output] << type::Output.new(count += 1, device, opts) unless device.get_max_receivers.zero?
        available_devices[:input] << type::Input.new(count += 1, device, opts) unless device.get_max_transmitters.zero?
      end
      available_devices
    end
  end
end
