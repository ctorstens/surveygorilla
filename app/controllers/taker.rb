get '/view/:token' do 
  @survey = Survey.find_by_token(params[:token])
  @questions = @survey.questions.order('position')
  @completion = Completion.where("taker_id = ? AND survey_id = ?", current_user.id, @survey.id)
  @completed = @completion.any?
	erb :view
end 

post '/view/:token' do
  survey_id = Survey.find_by_token(params[:token]).id
  if Completion.create(taker_id: current_user.id, survey_id: survey_id).valid?
    mcq_responses = params[:options]
    mcq_responses.each do |question_id, option_id|
      Response.create(question_id: question_id, completion_id: Completion.last.id, option_id: option_id)
    end
    text_responses = params[:answers]
    text_responses.each do |question_id, answer|
      Response.create(question_id: question_id, completion_id: Completion.last.id, answer: answer)
    end
  end
  redirect "/view/#{params[:token]}/survey_complete"
end

get '/view/:token/survey_complete' do
  erb :survey_complete
end
