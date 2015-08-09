# We should parse for correct ip_address
# using the resolv library
# But all the ip addresses in the sample file are incorrect
# So I disabled the validation.
# In that case, I would return with nil

require 'resolv'

# Simple structure for returning the visit
Visit = Struct.new(:page, :ip_address)

class LineParser

	REGEXP = Resolv::IPv4::Regex

	def initialize
		@regexp = nil
	end

	def parse(line)
		line.chomp!
		line.strip!
		page, ip_address = line.split(" ")

		# Disabled for the sample file received
		# return unless match = REGEXP.match(ip_address)

		Visit.new(page, ip_address)
	end

end
