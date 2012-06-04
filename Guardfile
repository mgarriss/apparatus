guard 'rspec', :version => 2, :cli => '--color --format doc', :all_on_start => true, :all_after_pass => true do
  watch(%r{^spec/.+_spec\.rb$}) { 'spec' }
  watch(%r{^lib/(.+)\.rb$}) { 'spec' }
  watch('spec/spec_helper.rb')  { "spec" }
end

# guard 'bundler' do
#   watch('Gemfile')
#   # Uncomment next line if Gemfile contain `gemspec' command
#   # watch(/^.+\.gemspec/)
# end

# guard 'spork', :rspec_env => {:version => 2, :cli => '--drb --color --format doc', :all_on_start => true, :all_after_pass => true } do
#   watch('config/application.rb')
#   watch('config/environment.rb')
#   watch(%r{^config/environments/.+\.rb$})
#   watch(%r{^config/initializers/.+\.rb$})
#   watch('Gemfile')
#   watch('Gemfile.lock')
#   watch('spec/spec_helper.rb') { :rspec }
# end
