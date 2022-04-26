# frozen_string_literal: true

# Main class for this task
# Example:
# LogParser.new(file_open_to_read).run
class LogParser
  def self.prepare(file_path = nil)
    file = open_file(file_path)
    new(file)
  end

  def initialize(file_io)
    @file = file_io
  end

  def run
    puts 'Hello World'
  end

  private

  attr_reader :file
end
