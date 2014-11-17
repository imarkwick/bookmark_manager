require 'spec_helper'
	
feature "User browses the list of links" do


	before(:each) {
	Link.create(:url => "http://www.makersacademy.com",
							:title => "Makers Academy",
							:tags => [Tag.first_or_create(:text => 'education')])
	Link.create(:url => "http://www.google.com",
							:title => "Google"
							:tags => [Tage.first_or_create(:text => 'search')])
	Link.create(:url => "http://www.bing.com",
							:title => "Bing",
							:tags => [Tage.forst_or_create(:text => 'search')])
	Link.create(:url => "http://www.code.org",
							:title => "Code.ord",
							:tags => [Tage.first_or_create(:text => 'education')])
	}
	end

	scenario "filtered by a tag" do
		visit '/tage/search'
		expect(page).not_to have_content("Makers Academy")
		expect(page).not_to have_content("Code.org")
		expect(page).to have_content("Google")
		expect(page).to have_content("Bing")
	end
end
