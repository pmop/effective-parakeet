RSpec.describe CountUniqueViewsStrategy do
  subject { CountUniqueViewsStrategy.new(data: data) }
  context 'when passing the usual data' do
    let(:data) do
      [
        ['/help_page/1', '126.318.035.038'],
        ['/help_page/1', '184.123.665.067'],
        ['/contact',     '184.121.665.067'],
        ['/help_page/1', '182.123.665.067'],
        ['/home',        '184.123.665.067'],
        ['/contact',     '184.123.665.067'],
      ]
    end
    let(:expected_output) do
        "/home 1 unique views\n" \
        "/contact 2 unique views\n" \
        "/help_page/1 3 unique views\n"
    end

    it 'returns the correct data' do
      expect(subject.call).to eq(expected_output)
    end
  end

  context 'when passing no data' do
    let(:data) do
      []
    end

    let(:expected_output) do
      ''
    end

    it 'returns the correct data' do
      expect(subject.call).to eq(expected_output)
    end
  end

  context 'when passing unexpected parameters' do
    let(:data) { nil }

    it 'returns the correct data' do
      error_msg = 'Unexpected parameter "data" value type.' \
                  ' "data" is expected to be a "String"'

      expect { subject.call }.to raise_error(
        ArgumentError, error_msg
      )
    end
  end
end
