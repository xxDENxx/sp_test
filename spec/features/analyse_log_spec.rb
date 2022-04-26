# frozen_string_literal: true

require 'spec_helper'
require 'log_parser'

describe 'analyse_log' do
  subject(:analyse_log) { LogParser.prepare(file_path).run }
  let(:file_path) { './spec/fixtures/correct.log' }
  let(:message) do
    "Total views:\n"\
      "/help_page/1 4 visits\n"\
      "/home 2 visits\n"\
      "/contact 1 visits\n"\
      "/about/2 1 visits\n"\
      "/index 1 visits\n"\
      "/about 1 visits\n"\
      "Uniq views:\n"\
      "/help_page/1 3 unique views\n"\
      "/home 2 unique views\n"\
      "/contact 1 unique views\n"\
      "/about/2 1 unique views\n"\
      "/index 1 unique views\n"\
      "/about 1 unique views\n"
  end

  it { expect { analyse_log }.to output(message).to_stdout }
end
