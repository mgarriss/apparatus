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
          if inf.get_name == name
            if device = MidiSystem.get_midi_device(inf)
              if self.ancestors.include? Input
                return new(device,name) if device.get_max_transmitters != 0
              else
                return new(device,name) if device.get_max_receivers != 0
              end
            end
          end
        end
        error "#{name} could not be found"
      end
      
      def initialize(device, name)
        info name
        @device, @name = device, name
        super()
        @device.open
      rescue Java::JavaxSoundMidi::MidiUnavailableException
        error "#{name} could not be found"
      end

      def close
        @device.close
      end
    end
  end
end
