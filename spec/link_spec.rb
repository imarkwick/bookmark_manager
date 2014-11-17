require 'spec_helper'

describe Link do 

	context "Demonstration of how datamapper works" do

		it 'should be created and then retrieved from the db' do
			# to begin with, the database should be empty
			expect(Link.count).to eq 0
			# to create it in the database so it's stored in the disk
			Link.create(:title => "Makers Academy", :url => "http://www.makersacademy.com/")
			expect(Link.count).to eq 1
			# to get the first (and only) link from the database
			link = Link.first
			# now it has all properties that it was saved with
			expect(link.url).to eq("http://www.makersacademy.com/")
			expect(link.title).to eq("Makers Academy")
			# the link can also be destroyed
			link.destroy
			expect(Link.count).to eq(0)
		end
	end
end