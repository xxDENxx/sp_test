# frozen_string_literal: true

require './lib/errors/wrong_format'

module Validators
  class Row
    REG_EXP = /^[^\s]+\s\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/.freeze

    def initialize(row)
      @row = row
    end

    def validate!
      raise Errors::WrongFormat unless row.match(REG_EXP)
    end

    private

    attr_reader :row
  end
end
