before do
  @current_user = current_user
end

get '/' do
  redirect to('/profile') if @current_user
  erb :index
end

get '/signin' do
  user = User.authenticate(params[:signin][:email], params[:signin][:password])
  if user
    session[:id] = user.id
    redirect to('/profile')
  else
    "Invalid login"
  end
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

get '/logout' do
  session.clear
  redirect '/'
end

get '/test' do
  p params
  erb :test
end

post '/test' do
  p params
  redirect to('/test')
end
