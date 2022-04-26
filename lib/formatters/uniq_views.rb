# frozen_string_literal: true

module Formatters
  class UniqViews
    def initialize(sorted_data)
      @data = sorted_data
    end

    def format
      data.map { |url, attr| formatted_string(url, attr) }.join("\n")
    end

    private

    attr_reader :data

    def formatted_string(url, attr)
      "#{url} #{attr[:uniq_ips].count} unique views"
    end
  end
end
