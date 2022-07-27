# frozen_string_literal: true

require 'set'

# Count unique views per endpoint given the data structure
class CountUniqueViewsStrategy
  # @param data [Array<Array<String>>] i.e. [['/endpoint', '0.0.0.0']]
  def initialize(data:)
    @data = data

    validate_params!(data)
  end

  # @return [String] multiline counting unique views per endpoint
  def call
    return '' if data.empty?

    format_to_print(unique_views)
  end

  private

  attr_reader :data

  def unique_views
    hash = data.each_with_object(Hash.new([])) do |data_pair, memo|
      endpoint, ipv4 = data_pair
      memo[endpoint] = [*memo[endpoint], ipv4]

      memo
    end

    hash.transform_values { |v| Set.new(v).count }
  end

  def format_to_print(unique_views)
    unique_views.to_a
                .sort_by(&:last)
                .to_h
                .transform_values do |v|
                  " #{v} unique views\n"
                end
                .to_a
                .reduce(&:+)
                .join
  end

  def validate_params!(data)
    return if data.is_a?(Array)

    error_msg = 'Unexpected parameter "data" value type.' \
                ' "data" is expected to be a "String"'
    raise ArgumentError, error_msg
  end
end
