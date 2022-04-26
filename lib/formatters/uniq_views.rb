# frozen_string_literal: true

require './lib/formatters/base'

module Formatters
  class UniqViews < Base
    private

    def formatted_string(url, attr)
      "#{url} #{attr[:uniq_ips].count} unique views"
    end
  end
end
