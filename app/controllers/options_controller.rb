get '/families/:family_id/users/:user_id/polls/:poll_id/options/new' do
  require_user
  @poll = Poll.find_by(id: params[:poll_id])
  erb :"/options/new"
end

post '/polls/:poll_id/options/new' do
  option = Option.new(description: params[:description])
  poll = Poll.find_by(id: params[:poll_id])
  if option.save
    poll.options << option
    redirect "/families/#{current_user.family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new"
  else
    redirect "/families/#{current_user.family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new?notice=something%20went%20wrong"
  end
end
