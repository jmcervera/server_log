require 'spec_helper'
require 'unique_page_view_stats'

RSpec.describe UniquePageViewStats do
	it { is_expected.to respond_to(:print) }
end

