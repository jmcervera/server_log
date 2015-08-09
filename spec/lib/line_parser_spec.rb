require 'spec_helper'
require 'line_parser'

RSpec.describe LineParser do
  it "parses a line returnning a visit" do
  	line_parser = LineParser.new
  	visit = line_parser.parse("/about 127.0.0.0")
  	expect(visit.page).to eq('/about')
  	expect(visit.ip_address).to eq('127.0.0.0')
  end
end
