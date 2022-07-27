class Parser
  def initialize(data:)
    @data = data

    validate_param!(data)
  end

  private

  attr_reader :data

  def validate_param!(param)
    return if param.is_a?(String)

    raise ArgumentError, 'Unexpected parameter "data" value type. "data" is expected to be a "String"'
  end
end
