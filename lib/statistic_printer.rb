# frozen_string_literal: true

require './lib/formatters/total_views'
require './lib/formatters/uniq_views'

class StatisticPrinter
  def print_total_views(collection)
    puts 'Total views:'
    puts Formatters::TotalViews.new(collection.sort_by_total).format
  end

  def print_uniq_views(collection)
    puts 'Uniq views:'
    puts Formatters::UniqViews.new(collection.sort_by_uniq).format
  end
end
