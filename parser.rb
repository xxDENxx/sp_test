#!/usr/bin/ruby
# frozen_string_literal: true

require './lib/log_parser'

file_path = ARGV[0]
LogParser.prepare(file_path).run
