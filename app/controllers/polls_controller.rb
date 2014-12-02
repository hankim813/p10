get '/polls/new' do
  require_user
  @notice = params[:notice]
  erb :"/polls/new"
end

get '/polls/:poll_id/edit' do
  require_user
  # DO THIS FOR ALL THE GET ROUTES
  if @poll = Poll.find_by(id: params[:poll_id])
    erb :'polls/edit'
  else
    redirect "/families/#{current_user.family.id}/show?notice=poll%20not%20found"
  end
end

post '/polls/new' do
  require_user
  poll = Poll.new(question: params[:question], description: params[:description])
  if poll.save
    current_user.polls << poll
    if tag = Tag.find_by(word: params[:tag_word].downcase)
      if tag.save
        current_user.tags << tag
        poll.tags << tag
        redirect "/families/#{current_user.family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new"
        return
      end
    else
      tag = Tag.new(word: params[:tag_word].downcase)
      if tag.save
        current_user.tags << tag
        poll.tags << tag
        redirect "/families/#{current_user.family.id}/users/#{current_user.id}/polls/#{poll.id}/options/new"
        return
      end
    end
  else
    redirect "/polls/new?notice=something%20went%20wrong"
    return
  end
end


delete '/polls/:poll_id/delete' do
  require_user
  if Poll.find_by(id: params[:poll_id]).destroy
    redirect "/families/#{current_user.family.id}/show?notice=poll%20sucessfully%20deleted"
    return
  else
    redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong"
    return
  end
end

put '/polls/:poll_id/edit' do
  require_user
  if Poll.find_by(id: params[:poll_id]).update_attributes(params[:poll])
    redirect "/families/#{current_user.family.id}/show?notice=poll%20sucessfully%20edited"
  else
    redirect "/families/#{current_user.family.id}/show?notice=poll%20not%20found"
  end
end