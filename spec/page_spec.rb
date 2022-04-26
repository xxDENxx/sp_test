# frozen_string_literal: true

require 'spec_helper'
require 'page'

describe Page do
  describe '.parse_row' do
    subject(:parse_row) { described_class.parse_row(row) }

    context 'when wrong format of row' do
      let(:row) { 'wrong_row' }

      it { expect { parse_row }.to raise_error(Errors::WrongFormat) }
    end

    context 'when correct format of row' do
      let(:row) { '/page/url 192.168.0.1' }

      it 'correct parse' do
        page = parse_row
        expect(page.url).to eq('/page/url')
        expect(page.ip).to eq('192.168.0.1')
      end
    end
  end
end
