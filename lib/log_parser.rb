# frozen_string_literal: true

require './lib/errors/file_not_found'
require './lib/errors/path_not_specified'
require './lib/errors/empty_file'
require './lib/errors/wrong_permission'

# Main class for this task
# Example:
# LogParser.new(file_open_to_read).run
class LogParser
  def self.prepare(file_path = nil)
    file = open_file(file_path)
    new(file)
  end

  def initialize(file_io, stat_printer = StatisticPrinter.new)
    @file = file_io
    @statistic_printer = stat_printer
  end

  def run
    puts "Hello world"
  end

  private

  attr_reader :file, :statistic_printer

  private_class_method def self.open_file(file_path)
  end
end
