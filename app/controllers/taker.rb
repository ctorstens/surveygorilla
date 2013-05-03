get '/view/:token' do 

	erb :view
end 

post '/view/:token' do
  # where we show a success notification?
  redirect to('/profile')
end
