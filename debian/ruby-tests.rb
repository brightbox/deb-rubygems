$: << 'lib' << 'test' << '.'
EXC_TESTS = [
  'test/rubygems/functional.rb',
  'test/rubygems/insure_session.rb',
]

begin
  require 'rubygems'
  require 'minitest/autorun'
rescue LoadError
  $stderr.puts "WARNING: Skipped tests due to lack of dependency libraries."
  exit
end
(Dir['{spec,test}/**/test_*.rb'] - EXC_TESTS).each { |f| require f }
