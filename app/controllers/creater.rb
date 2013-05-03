get '/profile' do
  @surveys = @current_user.surveys
	erb :profile
end

post '/survey' do
  survey = Survey.create(token: "abcd")
	redirect to("/survey/#{survey.token}")
end

get '/survey/:token' do
  @survey = Survey.find_by_token(params[:token])
	erb :survey
end

post '/survey/:token' do

  redirect to('/profile/#{survey.token}')
end

get '/profile/:token' do

  erb :detail
end

