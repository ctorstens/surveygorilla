require 'bcrypt'

class User < ActiveRecord::Base
	has_many :surveys
	has_many :completions, foreign_key: "taker_id"
	before_create :generate_token

	include BCrypt

	def generate_token
		self.token = SecureRandom.hex(4)
	end

	def password
		@password ||= Password.new(password_hash)
	end

	def password=(new_password)
		@password = Password.create(new_password)
		self.password_hash = @password
	end

	def self.authenticate(email, password) 
		user = User.where("email = ?", email).first
		if user && user.password == password
			user 
		else
			nil  
		end
	end  
end
