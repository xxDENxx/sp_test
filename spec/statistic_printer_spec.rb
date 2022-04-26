# frozen_string_literal: true

require 'spec_helper'
require 'page_collection'
require 'page'
require 'statistic_printer'

describe StatisticPrinter do
  let(:collection) { PageCollection.new }
  let(:page1) { Page.new(url: 'url1', ip: 'ip1') }
  let(:page2) { Page.new(url: 'url2', ip: 'ip1') }
  let(:page3) { Page.new(url: 'url1', ip: 'ip2') }
  let(:page4) { Page.new(url: 'url2', ip: 'ip1') }
  before do
    collection.add_page(page1)
    collection.add_page(page2)
    collection.add_page(page3)
    collection.add_page(page4)
  end

  describe '#print_total_views' do
    subject(:print_total) { described_class.new.print_total_views(collection) }
    let(:message) do
      "Total views:\n"\
        "url1 2 visits\n"\
        "url2 2 visits\n"
    end

    it { expect { print_total }.to output(message).to_stdout }
  end

  describe '#print_uniq_views' do
    subject(:print_uniq) { described_class.new.print_uniq_views(collection) }
    let(:message) do
      "Uniq views:\n"\
        "url1 2 unique views\n"\
        "url2 1 unique views\n"
    end

    it { expect { print_uniq }.to output(message).to_stdout }
  end
end
