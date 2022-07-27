RSpec.describe Parser do
  subject { described_class.new(data: data) }
  describe '.new' do
    context "when parameter 'data' value is not valid" do
      it 'raises the correct error' do
        expect { described_class.new(data: nil) }.to raise_error(
          'Unexpected parameter "data" value type. "data" is expected to be a "String"'
        )
      end
    end
  end

  describe '#call' do
    context 'when data is empty string' do
      let(:data) { '' }

      it 'returns empty array' do
        expect(subject.call).to eq([])
      end
    end

    context 'when data cannot be parsed' do
      context 'malformed line' do
        let(:data) { '/help_page/1126.318.035.038' }

        it 'raises the correct error' do
          error_msg = 'Failed to parse the data. Expected' +
                      ' line with endpoint and ipv4 separated by space.'

          expect { subject.call }.to raise_error(
            Errors::CannotParseError, error_msg
          )
        end
      end
    end

    context 'when passing the usual data' do
      let(:data) do
        <<-HEREDOC
        /help_page/1 126.318.035.038
        /contact 184.123.665.067
        /home 184.123.665.067
        /contact 184.123.665.067
        HEREDOC
      end

      it 'returns the correct data' do
        expect(subject.call).to eq(
          [
            ['/help_page/1', '126.318.035.038'],
            ['/contact',     '184.123.665.067'],
            ['/home',        '184.123.665.067'],
            ['/contact',     '184.123.665.067']
          ]
        )
      end
    end
  end
end
