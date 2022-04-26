# frozen_string_literal: true

require './lib/errors/file_not_found'
require './lib/errors/path_not_specified'
require './lib/validators/file'
require './lib/page_collection'
require './lib/page'
require './lib/statistic_printer'

# Main class for this task
# Example:
# LogParser.new(file_open_to_read).run
class LogParser
  def self.prepare(file_path = nil)
    raise Errors::PathNotSpecified unless file_path

    file = open_file(file_path)
    Validators::File.new(file).validate!
    new(file)
  end

  def initialize(file_io, stat_printer = StatisticPrinter.new)
    @file = file_io
    @statistic_printer = stat_printer
  end

  def run
    collection = PageCollection.new
    file.each do |line|
      page = Page.parse_row(line)
      collection.add_page(page)
    end
    statistic_printer.print_total_views(collection)
    statistic_printer.print_uniq_views(collection)
  end

  private

  attr_reader :file, :statistic_printer

  private_class_method def self.open_file(file_path)
    File.open(file_path)
  rescue Errno::ENOENT
    raise Errors::FileNotFound
  rescue Errno::EACCES
    raise Errors::WrongPermission
  end
end
