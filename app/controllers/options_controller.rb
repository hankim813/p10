# CLEAN THE ROUTE LINKS!! USE WILDCARD

get '/families/:family_id/users/:user_id/polls/:poll_id/options/new' do
  require_user
  if @poll = Poll.find_by(id: params[:poll_id])
    erb :"/options/new"
  else
    redirect "/families/#{current_user.family.id}/show?notice=poll%20not%20found"
    return
  end
end

get '/polls/:poll_id/options/:option_id/edit' do
  require_user
  if @option = Option.find_by(id: params[:option_id])
    erb :"/options/edit"
  else
    redirect "/families/#{current_user.family.id}/show?notice=option%20not%20found"
    return
  end
end

post '/polls/:poll_id/options/new' do
  require_user
  option = Option.new(description: params[:description])
  if poll = Poll.find_by(id: params[:poll_id]) && option.save
    poll.options << option
    redirect "/families/#{current_user.family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new"
    return
  else
    redirect "/families/#{current_user.family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new?notice=something%20went%20wrong"
    return
  end
end

put '/polls/:poll_id/options/:option_id/edit' do
  require_user
  if option = Option.find_by(id: params[:option_id])
    if option.update_attribute(:description, params[:description])
      redirect "/polls/#{option.poll.id}/edit"
      return
    end
  else
    redirect "/polls/#{option.poll.id}/options/#{option.id}/edit?notice=option%20could%20not%20update"
    return
  end
end

delete '/polls/:poll_id/options/:option_id/delete' do
  require_user
  poll = Poll.find_by(id: params[:poll_id])
  if Option.find_by(id: params[:option_id]).destroy
    redirect "polls/#{poll.id}/edit?notice=option%20successfully%20deleted"
    return
  else
    redirect "polls/#{poll.id}/edit?notice=option%20not%20found"
    return
  end
end
