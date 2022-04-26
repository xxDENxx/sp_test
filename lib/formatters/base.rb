# frozen_string_literal: true

module Formatters
  class Base
    def initialize(sorted_data)
      @data = sorted_data
    end

    def format
      data.map { |url, attr| formatted_string(url, attr) }.join("\n")
    end

    private

    attr_reader :data

    def formatted_string(url, attr)
      raise NotImplementedError
    end
  end
end
