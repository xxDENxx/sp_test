# frozen_string_literal: true

require './lib/formatters/base'

module Formatters
  class TotalViews < Base
    private

    def formatted_string(url, attr)
      "#{url} #{attr[:total]} visits"
    end
  end
end
