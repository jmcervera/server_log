class PageViewStats
	def print(pages)
		puts
		puts "Page Views"
		puts "----------"
		pages.sort_by{|k, v| v.views }.reverse.each do |page, stats|
			puts "#{page}: #{stats.views} Visitas"
		end
	end
end
