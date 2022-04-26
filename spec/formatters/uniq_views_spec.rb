# frozen_string_literal: true

require 'spec_helper'
require 'formatters/uniq_views'

describe Formatters::UniqViews do
  let(:collection) { PageCollection.new }
  let(:correct) do
    "/help_page/1 3 unique views\n"\
      "/home 2 unique views\n"\
      "/contact 1 unique views\n"\
      "/about/2 1 unique views\n"\
      "/index 1 unique views\n"\
      '/about 1 unique views'
  end

  before do
    File.open('./spec/fixtures/correct.log').each do |line|
      collection.add_page(Page.parse_row(line))
    end
  end

  it 'formats the collection' do
    expect(described_class.new(collection.sort_by_uniq).format).to eq correct
  end
end
