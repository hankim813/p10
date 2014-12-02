get '/polls/new' do
  @notice = params[:notice]
  erb :"/polls/new"
end

post '/polls/new' do
  require_user
  poll = Poll.new(question: params[:question])
  if poll.save
    current_user.polls << poll
    redirect "/families/#{current_user.family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new"
    return
  else
    redirect "/polls/new?notice=something%20went%20wrong"
    return
  end
end