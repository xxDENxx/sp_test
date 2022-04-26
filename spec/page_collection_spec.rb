# frozen_string_literal: true

require 'spec_helper'
require 'page_collection'

describe PageCollection do
  describe '#add_page' do
    subject(:add_page) { collection.add_page(page) }
    let(:collection) { described_class.new }
    let(:page) { Page.new(url: page_url, ip: ip) }
    let(:page_url) { '/page/url' }
    let(:ip) { '192.168.0.1' }

    context 'when new page' do
      let(:before) { nil }
      let(:after) { { total: 1, uniq_ips: [ip] } }

      it { expect { add_page }.to change { collection.collection[page_url] }.from(before).to(after) }
    end

    context 'when repeated page' do
      let(:before) { { total: 1, uniq_ips: [ip] } }
      let(:after) { { total: 2, uniq_ips: [ip] } }

      before do
        collection.add_page(page)
      end

      it { expect { add_page }.to change { collection.collection[page_url] }.from(before).to(after) }
    end
  end

  describe '#sort_by_total' do
    subject(:sort) { collection.sort_by_total }
    let(:collection) { described_class.new }
    let(:page1) { Page.new(url: 'url1', ip: 'ip1') }
    let(:page2) { Page.new(url: 'url2', ip: 'ip1') }
    let(:page3) { Page.new(url: 'url2', ip: 'ip1') }

    before do
      collection.add_page(page1)
      collection.add_page(page2)
      collection.add_page(page3)
    end

    let(:sorted) do
      [
        ['url2', { total: 2, uniq_ips: ['ip1'] }],
        ['url1', { total: 1, uniq_ips: ['ip1'] }]
      ]
    end

    it { is_expected.to eq(sorted) }
  end

  describe '#sort_by_uniq' do
    subject(:sort) { collection.sort_by_uniq }
    let(:collection) { described_class.new }
    let(:page1) { Page.new(url: 'url1', ip: 'ip1') }
    let(:page2) { Page.new(url: 'url1', ip: 'ip1') }
    let(:page3) { Page.new(url: 'url2', ip: 'ip1') }
    let(:page4) { Page.new(url: 'url2', ip: 'ip2') }

    before do
      collection.add_page(page1)
      collection.add_page(page2)
      collection.add_page(page3)
      collection.add_page(page4)
    end

    let(:sorted) do
      [
        ['url2', { total: 2, uniq_ips: %w[ip1 ip2] }],
        ['url1', { total: 2, uniq_ips: ['ip1'] }]
      ]
    end

    it { is_expected.to eq(sorted) }
  end
end
