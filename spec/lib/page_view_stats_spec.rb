require 'spec_helper'
require 'page_view_stats'

RSpec.describe PageViewStats do
	it { is_expected.to respond_to(:print) }
end
