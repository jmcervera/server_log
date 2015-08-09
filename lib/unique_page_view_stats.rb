class UniquePageViewStats
	def print(pages)
		puts
		puts "Unique page views"
		puts "-----------------"
		pages.sort_by{|k, v| v.addresses.size }.reverse.each do |page, stats|
			puts "#{page}: #{stats.addresses.size} unique views"
		end
	end
end
