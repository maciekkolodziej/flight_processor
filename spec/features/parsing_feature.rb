RSpec.describe 'Parsing input file' do
  context 'when all entries are valid' do
    subject { File.read('spec/tmp/output.csv') }
    let(:expected_output) { File.read('spec/fixtures/only_valid/output.csv') }

    before do
      App.new(
          'input_file' => 'spec/fixtures/only_valid/input.csv',
          'output_file' => 'spec/tmp/output.csv',
          'quiet' => true
      )
    end

    it { expect(subject).to eq(expected_output) }
    it { expect(File.exists?('errors.csv')).to be(false) }
  end

  context 'when all entries are invalid' do
    let(:expected_errors) { File.read('spec/fixtures/only_invalid/errors.csv') }
    before do
      App.new(
          'input_file' => 'spec/fixtures/only_invalid/input.csv',
          'output_file' => 'spec/tmp/output.csv',
          'quiet' => true
      )
    end

    it { expect(File.exists?('spec/tmp/output.csv')).to be(false) }
    it { expect(File.read('errors.csv')).to eq(expected_errors) }
  end

  context 'when there are valid and invalid entries' do
    let(:expected_output) { File.read('spec/tmp/output.csv') }
    let(:expected_errors) { File.read('spec/fixtures/mixed/errors.csv') }
    before do
      App.new(
          'input_file' => 'spec/fixtures/mixed/input.csv',
          'output_file' => 'spec/tmp/output.csv',
          'quiet' => true
      )
    end

    it { expect(File.read('spec/tmp/output.csv')).to eq(expected_output) }
    it { expect(File.read('errors.csv')).to eq(expected_errors) }
  end
end
