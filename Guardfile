require 'rb-fsevent'

guard 'rspec', :version => 2, :cli => '--color --format doc', :all_on_start => true, :all_after_pass => true do
  watch(%r{^spec/.+_spec\.rb$}) { 'spec' }
  watch(%r{^lib/(.+)\.rb$}) { 'spec' }
  watch('spec/spec_helper.rb')  { "spec" }
end
