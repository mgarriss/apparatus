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
      Apparatus.timestamp - Apparatus::StartTime
    end
    
    def _log_line(type, line, io = $stdout)
      called_by = caller[1].split('in').last.sub('`','').sub("'",'').strip.ljust(9)
      io.print "[#{type}] #{thread_name}.#{now} #{called_by}"
      io.puts line
    end
    
    def error(line='')
      _log_line 'error', line, $stderr
    end
    
    def warn(line='')
      _log_line 'warn', line
    end
    
    def info(line='')
      _log_line 'info', line
    end
    
    def exception(e)
      error e.class
      error e.message
      e.backtrace[0..3].each do |line|
        error line
      end
    end
    
    def shield
      begin
        yield
      rescue => e
        exeception e
        warn 'shield moving on...'
      end
    end
  end
  
  def self.start(&ex)
    extend Logger
    info
    require 'apparatus/standard_agents'
    $reactor = Thread.start do
      EM.run do
        $executors = Executors.newCachedThreadPool
      end
    end
    if ex
      begin
        ex.call
      ensure
        Apparatus.stop
      end
    end
  end

  def self.stop
    info
    $reactor.kill if $reactor
    $executors.shutdown_now if $executors
  end
  
  def self.spin_off
    start unless $executors
    $executors.submit do
      shield do
        info 'begin spin_off'
        yield
        info 'end spin_off'
      end
    end
  end
end

