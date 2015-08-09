class Parser

		# Inner class for holding page statistics
		class PageStats
			attr_reader :views, :addresses
			def initialize
				@views = 0
				@addresses = []
			end
			def add_visit(ip_address)
				@views += 1
				@addresses << ip_address unless @addresses.include?(ip_address)
			end
		end

	attr_reader :pages_visited

	def initialize(path, line_parser)
		raise ArgumentError unless File.exists?(path)
		@log = File.open(path)
		@line_parser = line_parser
		@pages_visited = {}
	end

	def parse
		@log.each_line do |line|
			visit = @line_parser.parse(line)
			register_visit(visit) unless visit.nil? # When parsing ip fails
		end
	end

	def print_stats(printer)
		printer.print(@pages_visited)
	end

	private
	def register_visit(visit)
		unless @pages_visited.has_key?(visit.page)
			@pages_visited[visit.page] = PageStats.new
		end
		@pages_visited[visit.page].add_visit(visit.ip_address)
	end
end

