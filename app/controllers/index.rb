before do
  @current_user = current_user
end

get '/' do

  erb :index
end

get '/signin' do

	redirect to('/profile')
end

post '/signup' do 

	redirect to('/profile')
end

post '/logout' do

end






