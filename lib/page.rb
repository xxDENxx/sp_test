# frozen_string_literal: true

require './lib/validators/row'

# Represent one view from log
class Page
  attr_reader :ip, :url

  def self.parse_row(row)
    Validators::Row.new(row).validate!
    url, ip = row.split
    new(url: url, ip: ip)
  end

  def initialize(url:, ip:)
    @ip = ip
    @url = url
  end
end
