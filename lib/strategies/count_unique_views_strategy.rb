require 'set'

class CountUniqueViewsStrategy
  def initialize(data:)
    @data = data
  end

  def call
    unique_views = data.reduce(Hash.new([])) do |memo, data_pair|
      endpoint, ipv4 = data_pair

      memo.tap { memo[endpoint] = [*memo[endpoint], ipv4] }
    end

    unique_views.transform_values { |v| Set.new(v).count }

    to_print = unique_views.to_a
                           .sort_by(&:last)
                           .to_h

    to_print.transform_values do |v|
      " #{Set.new(v).count} unique views\n"
    end
      .to_a
      .reduce(&:+)
      .join
  end

  private
  attr_reader :data
end
