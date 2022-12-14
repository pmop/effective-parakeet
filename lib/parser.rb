# frozen_string_literal: true

# Reads some structured data and turns into a data structure
class Parser
  # @param data [String]
  def initialize(data:)
    @data = data

    validate_param!(data)
  end

  # @return [Array<Array<String>>] i.e. [['/endpoint', '0.0.0.0']]
  def call
    return [] if data.empty?

    data.lines(chomp: true).map do |line|
      parsed = line.split(' ')

      raise_parser_error unless parsed.count == 2

      parsed
    end
  end

  private

  attr_reader :data

  def validate_param!(param)
    return if param.is_a?(String)

    raise ArgumentError, 'Unexpected parameter "data" value type. "data" is expected to be a "String"'
  end

  def raise_parser_error
    error_msg = 'Failed to parse the data. Expected' \
                ' line with endpoint and ipv4 separated by space.'

    raise Errors::CannotParseError, error_msg
  end
end
