get '/profile' do
  @surveys = @current_user.surveys
	erb :profile
end

post '/survey' do

	redirect to('/survey/#{survey.token}')
end

get '/survey/:token' do

	erb :survey
end

post '/survey/:token' do

  redirect to('/profile/#{survey.token}')
end

get '/profile/:token' do

  erb :detail
end

