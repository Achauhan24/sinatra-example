require 'sinatra/activerecord'

class UsersController < Sinatra::Base
	get '/users' do
		@users = User.all
		json @users
	end

	get '/users/:id' do
		@user = User.find(params[:id])
		json @user	
	end

	post '/users' do
		@user = User.new(first_name: params[:name], last_name:params[:last_name], username: params[:username], email: params[:email],
			encrypted_password: hash_password(params[:password]))
		if @user.save
			json @user
		else
			content_type :json
			json error: @user.errors.messages, status: 422
		end
	end

	def hash_password(password)
		BCrypt::Password.create(password)
	end
end