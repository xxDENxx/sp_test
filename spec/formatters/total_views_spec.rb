# frozen_string_literal: true

require 'spec_helper'
require 'formatters/total_views'

describe Formatters::TotalViews do
  let(:collection) { PageCollection.new }
  let(:correct) do
    "/help_page/1 4 visits\n/home 2 visits\n/contact 1 visits\n/about/2 1 visits\n/index 1 visits\n/about 1 visits"
  end

  before do
    File.open('./spec/fixtures/correct.log').each do |line|
      collection.add_page(Page.parse_row(line))
    end
  end

  it 'formats the collection' do
    expect(described_class.new(collection.sort_by_total).format).to eq correct
  end
end
