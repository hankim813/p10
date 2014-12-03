post '/families/:family_id/users/:user_id/polls/:poll_id/options/:option_id/votes/new' do
  require_user
  authenticate_family_access(params[:family_id])
  if (poll = current_family.polls.find_by(id: params[:poll_id])) && (option = current_family.options.find_by(id: params[:option_id]))
    vote = Vote.new(option_id: option.id, voter_id: current_user.id)
    if vote.save
      option.vote_count += 1
      option.save
      redirect "/families/#{current_user.family.id}/show?notice=vote%20sucess"
      return
    else
      redirect "/families/#{current_user.family.id}/show?notice=vote%20no%20save"
    end
  else
    redirect "/families/#{current_user.family.id}/show?notice=option%20not%20found"
    return
  end
end

delete "/families/:family_id/users/:user_id/polls/:poll_id/options/:option_id/votes/:vote_id/delete" do
  require_user
  authenticate_family_access(params[:family_id])
  if current_family.votes.find_by(id: params[:vote_id]).destroy
    option = current_family.options.find_by(id: params[:option_id])
    option.vote_count -= 1
    option.save
    redirect "/families/#{current_user.family.id}/show?notice=vote%20cancelled"
  else
    redirect "/families/#{current_user.family.id}/show?notice=vote%20not%20found"
  end
end