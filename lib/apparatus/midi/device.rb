module Apparatus
  module MIDI
    class Device < Agent
      import javax.sound.midi.MidiSystem
      import javax.sound.midi.MidiDevice
      import javax.sound.midi.MidiEvent
      import javax.sound.midi.Receiver
      
      attr_reader :id, :name, :description, :vendor

      def self.find(name)
        MidiSystem.get_midi_device_info.each do |inf|
          info inf.get_name
          if inf.get_name == name
            if device = MidiSystem.get_midi_device(inf)
              info device.get_max_transmitters
              info device.get_max_receivers
              if self.class == Input
                if device.get_max_transmitters != 0
                  return new(device,name)
                end
              else
                if device.get_max_receivers != 0
                  return new(device,name)
                end
              end
            end
          end
        end
        error "#{name} could not be found"
      end
      
      def initialize(device, name)
        info
        @device, @name = device, name
        @device.open
        super()
      rescue Java::JavaxSoundMidi::MidiUnavailableException
        error "#{name} could not be found"
      end
      
      def close
        # @device.close
      end
    end
  end
end
