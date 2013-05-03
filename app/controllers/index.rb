before do
  @current_user = nil #current_user
end

get '/' do

  erb :index
end

get '/signin' do
  user = User.authenticate(params[:signin][:email], params[:signin][:password])
  if user 
    session[:id] = user.id
  else
    "Invalid login"
  end
  redirect to('/profile')
end

post '/signup' do 
  user = User.new(params[:signup])
  if user.save
    session[:id] = user.id
    redirect to('/profile')
  else
    # errors here
  end
end

post '/logout' do
  session[:id] = nil
  redirect '/'
end






