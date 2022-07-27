#!/usr/bin/env ruby
Dir['./lib/**/*.rb'].sort.each { |file| require file }

no_args_error_msg = 'No argument received. Please, '+
                    'run logparse with a valid file path to a valid log file.'

if ARGV.empty? || ARGV[0].empty?
  warn(no_args_error_msg)
  exit(1)
end
