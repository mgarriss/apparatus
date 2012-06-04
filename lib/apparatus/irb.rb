$logout = nil
# require 'jruby/profiler'

# profile_data = JRuby::Profiler.profile do
  # code to be profiled:
  require 'apparatus'
  include Apparatus

  Apparatus.start do
    require 'apparatus/standard_agents'
  end
# end

# profile_printer = JRuby::Profiler::GraphProfilePrinter.new(profile_data)
# profile_printer.printProfile(STDOUT)
