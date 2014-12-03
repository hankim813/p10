get '/families/:family_id/users/:user_id/polls/:poll_id/options/new' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if @poll = current_family.polls.find_by(id: params[:poll_id])
    erb :"/options/new"
  else
    redirect "/families/#{current_family.id}/show?notice=poll%20not%20found"
  end
end

get '/families/:family_id/users/:user_id/polls/:poll_id/options/:option_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if @option = current_family.options.find_by(id: params[:option_id])
    erb :"/options/edit"
  else
    redirect "/families/#{current_family.id}/show?notice=option%20not%20found"
  end
end

post '/families/:family_id/users/:user_id/polls/:poll_id/options/new' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  option = Option.new(description: params[:description])
  if poll = current_family.polls.find_by(id: params[:poll_id]) 
    if option.save
      poll.options << option
      redirect "/families/#{current_family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new"
    end
  else
    redirect "/families/#{current_family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new?notice=something%20went%20wrong"
  end
end

post '/families/:family_id/users/:user_id/polls/:poll_id/options/add' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  option = Option.new(description: params[:description])
  if poll = current_family.polls.find_by(id: params[:poll_id]) 
    if option.save
      poll.options << option
      redirect "/families/#{current_family.id}/users/#{current_user.id}/polls/#{poll.id}/edit"
    end
  else
    redirect "/families/#{current_family.id}/users/#{current_user.id}/polls/#{poll.id}/edit?notice=something%20went%20wrong"
  end
end

put '/families/:family_id/users/:user_id/polls/:poll_id/options/:option_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if option = current_family.options.find_by(id: params[:option_id])
    if option.update_attribute(:description, params[:description])
      redirect "/families/#{current_family.id}/users/#{current_user.id}/polls/#{option.poll.id}/edit"
    end
  else
    redirect "/families/#{current_family.id}/users/#{current_user.id}/polls/#{option.poll.id}/options/#{option.id}/edit?notice=option%20could%20not%20update"
  end
end

delete '/families/:family_id/users/:user_id/polls/:poll_id/options/:option_id/delete' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  poll = current_family.polls.find_by(id: params[:poll_id])
  if current_family.options.find_by(id: params[:option_id]).destroy
    redirect "/families/#{current_family.id}/users/#{current_user.id}/polls/#{poll.id}/edit?notice=option%20successfully%20deleted"
  else
    redirect "/families/#{current_family.id}/users/#{current_user.id}/polls/#{poll.id}/edit?notice=option%20not%20found"
  end
end
