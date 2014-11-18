require 'bcrypt'
require 'data_mapper'

class User

	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation

	property :id, Serial
	property :email, String, :unique => true, :message => "This email is already taken"

	validates_uniqueness_of :email
	validates_confirmation_of :password

	property :password_digest, Text

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end
end
