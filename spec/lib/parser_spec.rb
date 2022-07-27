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
  end
end
