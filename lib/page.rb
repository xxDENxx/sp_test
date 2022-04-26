# frozen_string_literal: true

require './lib/errors/wrong_format'

# Represent one view from log
class Page
  attr_reader :ip, :url

  def self.parse_row(row)
  end

  def initialize(url:, ip:)
    @ip = ip
    @url = url
  end
end
