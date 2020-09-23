require 'json'
require 'jwt'
require "dotenv/load"
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/contrib/all'

class SinatraExample < Sinatra::Base
	Dir["./app/models/*.rb"].each { |file| require file }
	Dir["./app/controllers/*.rb"].each { |file| require file }
	Dir[File.join(File.dirname(__FILE__), "lib", "*.rb")].each { |lib| require  lib}
	use ApplicationController
	use UsersController
	use SessionsController

	error do
		content_type :json
		status 400

		e = env['sinatra.error']
		{ result: 'error', message: e.message}.to_json
	end
end