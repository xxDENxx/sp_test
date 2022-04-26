# frozen_string_literal: true

require './lib/errors/empty_file'
require './lib/errors/wrong_permission'

module Validators
  class File
    def initialize(file_io)
      @file = file_io
    end

    def validate!
      raise Errors::EmptyFile unless file.stat.size.positive?
    end

    private

    attr_reader :file
  end
end
