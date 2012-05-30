guard 'rspec', :version => 2, :cli => '--color --format doc', :all_on_start => true, :all_after_pass => true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
end
