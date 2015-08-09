require 'spec_helper'
require "parser"
require "line_parser"

RSpec.describe Parser do
	let(:visit) { double("visit", page: '/about', ip_address: "127.0.0.0")}
	let(:line_parser) { double("line parser", parse: visit) }

	it "requires an existing file to parse" do
		path = "non-existent"
		allow(File).to receive(:exists?).with(path).and_return(false)
		expect{ Parser.new(path, line_parser) }.to raise_exception(ArgumentError)
	end

	it "opens the file if existing" do
		path = "webserver.log"
		allow(File).to receive(:exists?).with(path).and_return(true)
		expect(File).to receive(:open).with(path)
		Parser.new(path, line_parser)
	end

	describe "#parse" do
		let(:path) { "weserver.log "}
		let(:opened_file) { double("file")}
		let(:line) { "/about 127.0.0.0" }

		before do
			allow(File).to receive(:exists?).with(path).and_return(true)
			allow(File).to receive(:open).with(path).and_return(opened_file)
			allow(opened_file).to receive(:each_line).and_yield(line)
			@parser = Parser.new(path, line_parser)
		end

		it "opens the file for reading" do
			expect(opened_file).to receive(:each_line)
			@parser.parse
		end

		describe "process each line" do
			it "parses each line obtaining visit" do
				expect(line_parser).to receive(:parse).with(line)
				@parser.parse
			end

			it "register the visit" do
				@parser.parse
				pv = @parser.pages_visited
				expect(pv.has_key?('/about')).to be_truthy
				expect(pv['/about'].views).to eq(1)
				expect(pv['/about'].addresses).to eq ['127.0.0.0']
			end

			it "increment number of views on second visit to the page" do
				allow(opened_file).to receive(:each_line).and_yield(line).and_yield(line)
				@parser.parse
				pv = @parser.pages_visited
				expect(pv['/about'].views).to eq(2)
				expect(pv['/about'].addresses).to eq ['127.0.0.0']
			end
		end
	end

	describe "#print_stats" do
		it "prints the pages visited" do
			parser = Parser.new("webserver.log", LineParser.new)
			parser.parse
			expect(parser.print_stats).to eq(parser.pages_visited.to_s)
		end
	end

end
