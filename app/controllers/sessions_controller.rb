class SessionsController < Sinatra::Base

  post '/login' do
    @user = User.find_by(email: params[:email])

    if @user.valid_password?(params[:password], @user.encrypted_password)
      response.headers['X-ACCESS-TOKEN'] = @user.generate_token
      json message: 'Logged In Successfully!!!', status: :ok
    else
     json errors: 'Invalid email or Password', status: :unprocessable_entity
    end
  end
end