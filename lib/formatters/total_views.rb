# frozen_string_literal: true

module Formatters
  class TotalViews
    def initialize(sorted_data)
      @data = sorted_data
    end

    def format
      data.map { |url, attr| 'some string' }.join("\n")
    end

    private

    attr_reader :data
  end
end
