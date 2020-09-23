class User < ActiveRecord::Base
	validates :first_name, presence: true
	validates :email, uniqueness: true

	def generate_token(exp = true)
		payload = { id: id }
		(payload[:exp] = Time.current.to_i + 1.week) if exp
			JWT.encode(payload, 
			ENV['JWT_SECRET'],
			ENV['ALGORITHM'])
	end

	

	def valid_password?(password, hash)
		BCrypt::Password.new(hash) == password
	end
end