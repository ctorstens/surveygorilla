get '/view/:token' do 

	erb :survey
end 

post '/view/:token' do
  # where we show a success notification?
  redirect to('/profile')
end
