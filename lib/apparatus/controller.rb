java_import java.util.concurrent.Executors
$executors = Executors.newCachedThreadPool

module Apparatus
  def self.timestamp
    (Time.now.to_f % 100).to_s[0..5].sub('.','').to_i
  end
  
  StartTime = timestamp
  
  module Logger
    def thread_name
      [(Thread.current.object_id % 64)+64].pack('C')
    end
    
    def now
      (Apparatus.timestamp * 2) - Apparatus::StartTime
    end
    
    def _log_line(type, line, io = $stdout)
      n = ((name || self.class.to_s) rescue self.class.to_s)
      n = n.split('::').last
      n = n[0...12].ljust(12)
      c = caller[1].split('`').last.sub("'",'').strip[0...12].ljust(12)
      # self.class.instance_method(c.to_sym).source.display
      #io.puts "#{type}.#{thread_name}.#{now}.#{object_id} | #{n}.#{c} | #{line}"
      io.puts "#{type}.#{n}.#{c} | #{line}"
    end
    
    def error(line='')
      $stderr.puts
      _log_line 'error', line, $stderr
      $stderr.puts
      Apparatus.stop
    end
    
    def warn(line='')
      _log_line 'warn', line
    end
    
    def info(line='')
      _log_line 'info', line
    end
    
    def shield
      begin
        yield
      rescue => e
        warn e.class
        warn e.message
        warn e.backtrace[0].split(%r{/}).last
      end
    end
  end
  
  def self.start(&ex)
    extend Logger
    info
    $reactor = Apparatus.spin_off do
      EM::run(&ex)
    end
  end
  
  def self.stop
    if $reactor
      EM.stop_event_loop rescue nil
      sleep 2
      $executors.shutdown
    else
      EM.stop_event_loop rescue nil
    end
    `killall -9 java`
    `killall -9 sh`
  end
  
  def self.spin_off(&ex)
    $executors.submit do
      ex.call
    end
  end
end

