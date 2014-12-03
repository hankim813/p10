get '/families/:family_id/polls/new' do
  require_user
  authenticate_family_access(params[:family_id])
  @notice = params[:notice]
  erb :"/polls/new"
end

get '/families/:family_id/polls/:poll_id/show' do
  require_user
  authenticate_family_access(params[:family_id])
  if @poll = current_family.polls.find_by(id: params[:poll_id])
    erb :"/polls/show"
  else
    redirect "/families/#{current_user.family.id}/show?notice=poll%20not%20found"
    return
  end
end

get '/families/:family_id/polls/:poll_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  if @poll = current_family.polls.find_by(id: params[:poll_id])
    erb :'polls/edit'
  else
    redirect "/families/#{current_user.family.id}/show?notice=poll%20not%20found"
  end
end

post '/polls/new' do
  require_user
  poll = Poll.new(params[:poll])
  if poll.save
    current_user.polls << poll
    params[:tags] ? (tags = params[:tags].split(",").map(&:strip)) : (redirect "/families/#{current_user.family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new")
    tags.each do |tag_word|
      if tag = current_family.tags.find_by(word: tag_word.downcase)
        poll.tags << tag
      else
        tag = Tag.new(word: tag_word.downcase)
        if tag.save
          current_user.tags << tag
          poll.tags << tag
        else
          redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong%20with%20the%20tag"
          return
        end
      end
    end
    redirect "/families/#{current_user.family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new"
    return
  else
    redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong%20with%20the%20post"
    return
  end
end



delete '/families/:family_id/polls/:poll_id/delete' do
  require_user
  authenticate_family_access(params[:family_id])
  if current_family.polls.find_by(id: params[:poll_id]).destroy
    redirect "/families/#{current_user.family.id}/show?notice=poll%20sucessfully%20deleted"
    return
  else
    redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong"
    return
  end
end

put '/families/:family_id/polls/:poll_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  if current_family.polls.find_by(id: params[:poll_id]).update_attributes(params[:poll])
    redirect "/families/#{current_user.family.id}/show?notice=poll%20sucessfully%20edited"
  else
    redirect "/families/#{current_user.family.id}/show?notice=poll%20not%20found"
  end
end