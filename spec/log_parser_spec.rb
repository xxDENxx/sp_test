# frozen_string_literal: true

require 'spec_helper'
require 'log_parser'
require 'errors/wrong_format'

describe LogParser do
  describe '.prepare' do
    subject(:prepare_parser) { described_class.prepare(path_to_file) }
    let(:path_to_file) { 'tmp/test.log' }

    context 'when path is not provided' do
      let(:path_to_file) { nil }
      it { expect { prepare_parser }.to raise_error(Errors::PathNotSpecified) }
    end

    context 'when file do not exist' do
      it { expect { prepare_parser }.to raise_error(Errors::FileNotFound) }
    end

    context 'when file has wrong permission' do
      around do |example|
        FileUtils.touch(path_to_file)
        FileUtils.chmod(0o300, path_to_file)

        example.run

        FileUtils.rm(path_to_file)
      end

      it { expect { prepare_parser }.to raise_error(Errors::WrongPermission) }
    end

    context 'when file empty' do
      around do |example|
        FileUtils.touch(path_to_file)

        example.run

        FileUtils.rm(path_to_file)
      end

      it { expect { prepare_parser }.to raise_error(Errors::EmptyFile) }
    end

    context 'when file is correct' do
      around do |example|
        FileUtils.cp('./spec/fixtures/correct.log', path_to_file)

        example.run

        FileUtils.rm(path_to_file)
      end

      it { expect { prepare_parser }.not_to raise_error }
    end
  end

  describe '#run' do
    subject(:run_parser) { parser.run }
    let(:parser) { described_class.new(file_reader, statistic_printer) }
    let(:file_reader) { File.open('./spec/fixtures/correct.log') }
    let(:statistic_printer) { instance_double(StatisticPrinter) }

    before do
      expect(statistic_printer).to receive(:print_total_views)
      expect(statistic_printer).to receive(:print_uniq_views)
    end

    it 'must call all printings' do
      expect { run_parser }.not_to raise_error
    end
  end
end
