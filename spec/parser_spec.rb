RSpec.describe 'Log parser' do
  subject(:invoke_script) { system('./parser.rb' + script_arg) }

  context 'when running script with no argument' do
    let(:script_arg) { '' }

    it 'raises the correct info' do
      info_msg = 'No argument received. Please, ' +
                  'run logparse with a valid file path to a valid log file.'

      expect { invoke_script }.to output(a_string_including(info_msg))
        .to_stderr_from_any_process
    end
  end

  context 'when running script with invalid file path' do
    let(:script_arg) { ' ./bogus.txt' }

    it 'raises the correct info' do
      info_msg = 'File not found. Please, make sure the file path is valid.'

      expect { invoke_script }.to output(a_string_including(info_msg))
        .to_stderr_from_any_process
    end
  end

  context 'when running script with valid file' do
    let(:script_arg) { ' ./spec/fixtures/simple.log' }
    let(:expected_output) do
        "/home 1 unique views\n" \
        "/contact 2 unique views\n" \
        "/help_page/1 3 unique views\n"
    end

    it 'returns the correct output' do
      expect { invoke_script }.to output(a_string_including(expected_output))
        .to_stdout_from_any_process
    end
  end
end
