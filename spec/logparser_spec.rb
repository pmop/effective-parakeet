RSpec.describe 'Log parser' do
  subject(:invoke_script) { system('./logparser.rb' + script_arg) }

  context 'when running script with no argument' do
    let(:script_arg) { '' }

    it 'raises the correct error' do
      error_msg = 'No argument received. Please, '+
                  'run logparse with a valid file path to a valid log file.'

      expect { invoke_script }.to raise_error(
        Errors::NoArgumentsError, error_msg
      )
    end
  end
end