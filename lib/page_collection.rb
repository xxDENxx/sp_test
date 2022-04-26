# frozen_string_literal: true

# Represent all log structure
class PageCollection
  attr_reader :collection

  def initialize
    @collection = {}
  end

  def add_page(page)
    collection[page.url] ||= { total: 0, uniq_ips: [] }
    collection[page.url][:total] += 1
    ips = collection[page.url][:uniq_ips]
    ips << page.ip unless ips.include?(page.ip)
  end

  def sort_by_total
    custom_sort(->(x) { x.last[:total] })
  end

  def sort_by_uniq
    custom_sort(->(x) { x.last[:uniq_ips].count })
  end

  def custom_sort(sort_action)
    collection.sort { |a, b| sort_action.call(b) <=> sort_action.call(a) }
  end
end
