require 'data_mapper'
require './app/data_mapper_setup'

# define two tasks - auto_migrate and auto_upgrade
# whenever we want to run them just invoke rake from command line
# rake auto_migrate

task :auto_upgrade do
	
	# makes non-destructive changes e.g. prevents loss of data when making changes
	DataMapper.auto_upgrade!
	puts "Auto-upgrade complete (no data loss)"
end

task :auto_migrate do

	# to force creation of all tables as described in the models
	DataMapper.auto_migrate!
	puts "Auto-migrate complete (data could have been lost)"
end