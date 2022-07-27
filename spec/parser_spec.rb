RSpec.describe 'Log parser' do
  subject(:invoke_script) { system('./parser.rb' + script_arg) }

  context 'when running script with no argument' do
    let(:script_arg) { '' }

    it 'raises the correct info' do
      info_msg = 'No argument received. Please, ' +
                  'run logparse with a valid file path to a valid log file.'

      expect { invoke_script }.to output(a_string_including(info_msg)).to_stderr_from_any_process
    end
  end

  context 'when running script with invalid file path' do
    let(:script_arg) { ' ./bogus.txt' }

    it 'raises the correct info' do
      info_msg = 'File not found. Please, make sure the file path is valid.'

      expect { invoke_script }.to output(a_string_including(info_msg)).to_stderr_from_any_process
    end
  end
end
