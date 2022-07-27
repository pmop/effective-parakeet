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
  end
end
