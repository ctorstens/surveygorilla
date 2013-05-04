get '/view/:token' do 
  @survey = Survey.find_by_token(params[:token])
  @questions = @survey.questions
  @completed = Completion.where("taker_id = ? AND survey_id = ?", current_user.id, @survey.id)

	erb :view
end 

post '/view/:token' do
  survey_id = Survey.find_by_token(params[:token]).id
  if Completion.create(taker_id: current_user.id, survey_id: survey_id).valid?
    responses = params[:options]
    responses.each do |question_id, option_id|
      Response.create(question_id: question_id, completion_id: Completion.last.id, option_id: option_id)
    end
  end
  redirect "/view/#{params[:token]}/survey_complete"
end

get '/view/:token/survey_complete' do
  erb :survey_complete
end
