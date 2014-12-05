post '/families/:family_id/polls/:poll_id/options/:option_id/votes/new' do
  require_user
  authenticate_family_access(params[:family_id])
  if (poll = current_family.polls.find_by(id: params[:poll_id])) && (option = current_family.options.find_by(id: params[:option_id]))
    vote = Vote.new(option_id: option.id, voter_id: current_user.id)
    if vote.save
      option.votes << vote
      option.vote_count += 1
      option.save
      # require 'pry';
      # binding.pry
      redirect "/families/#{current_family.id}/show?notice=vote%20sucess#news-feed-anchor"
    else
      redirect "/families/#{current_family.id}/show?notice=vote%20no%20save#news-feed-anchor"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=option%20not%20found#news-feed-anchor"
  end
end

delete "/families/:family_id/users/:user_id/polls/:poll_id/options/:option_id/votes/:vote_id/delete" do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if current_family.votes.find_by(id: params[:vote_id]).destroy
    option = current_family.options.find_by(id: params[:option_id])
    option.vote_count -= 1
    option.save
    redirect "/families/#{current_family.id}/show?notice=vote%20cancelled#news-feed-anchor"
  else
    redirect "/families/#{current_family.id}/show?notice=vote%20not%20found#news-feed-anchor"
  end
end