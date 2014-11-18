require_relative 'tag'
require 'data_mapper'
# This class corresponds to a table in the database
# It can be used to manipulate the data

class Link

		# this makes the instance of this class Datamapper resources
		include DataMapper::Resource

		has n, :tags, :through => Resource
		# this block describes what resources our model will have
		property :id, Serial # Serial means that it will be auto-incremented for every record
		property :title, String 
		property :url, String
end
