get '/polls/new' do
  @notice = params[:notice]
  erb :"/polls/new"
end

post '/polls/new' do
  require_user
  poll = Poll.new(question: params[:question])
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