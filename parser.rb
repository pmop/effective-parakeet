#!/usr/bin/env ruby
Dir['./lib/**/*.rb'].sort.each { |file| require file }
require 'set'

no_args_error_msg = 'No argument received. Please, '+
                    'run logparse with a valid file path to a valid log file.'

file_not_found_error_msg = 'File not found. Please, make sure the file path is valid.'

if ARGV.empty? || ARGV[0].empty?
  warn(no_args_error_msg)
  exit(1)
end

if !File.exist?(ARGV[0])
  warn(file_not_found_error_msg)
  exit(1)
end

begin
  file_contents = File.read(ARGV[0])
  structured_data = Parser.new(data: file_contents).call

  unique_views = structured_data.reduce(Hash.new([])) do |memo, data_pair|
    endpoint, ipv4 = data_pair

    memo.tap { memo[endpoint] = [*memo[endpoint], ipv4] }
  end

  to_print = unique_views.to_a
                         .sort_by(&:last)
                         .to_h

  to_print = to_print.transform_values do |v|
    " #{Set.new(v).count} unique views\n"
  end

  puts to_print.to_a.reduce(&:+).join
rescue IOError => e
  puts e.message
end
