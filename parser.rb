#!/usr/bin/env ruby

# frozen_string_literal: true

Dir['./lib/**/*.rb'].sort.each { |file| require file }
no_args_error_msg = 'No argument received. Please, ' \
                    'run logparse with a valid file path to a valid log file.'

file_not_found_error_msg = 'File not found. Please, make sure the file path is valid.'

if ARGV.empty? || ARGV[0].empty?
  warn(no_args_error_msg)
  exit(1)
end

unless File.exist?(ARGV[0])
  warn(file_not_found_error_msg)
  exit(1)
end

begin
  file_contents = File.read(ARGV[0])
  structured_data = Parser.new(data: file_contents).call
  puts CountUniqueViewsStrategy.new(data: structured_data).call
rescue IOError => e
  puts e.message
end
