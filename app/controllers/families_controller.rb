get '/families/new' do
  require_user
  erb :'/families/new'
end

get '/families/:family_id/show' do
  require_user
  @family = Family.find_by(id: params[:family_id])
  @posts = @family.posts.reverse
  @polls = @family.polls
  @notice = params[:notice]
  erb :"/families/show"
end

get '/families/:family_id/edit' do
  require_user
  @family = Family.find_by(id: params[:family_id])
  erb :'/families/edit'
end

post '/families/new' do
  require_user
  family = Family.new(params[:family])
  user = current_user
  if family.save
    user.family = family
    family.password = user.family.id
    redirect "/families/#{user.family.id}/show"
  else
    @notice = "Something went wrong, please try again"
    erb :'/families/new'
  end
end

put '/families/:family_id' do
  require_user
  @family = Family.find_by(id: params[:family_id])
  if current_user.authenticate(params[:user][:password])
    @family.update_attributes(params[:family])
    redirect "/families/#{family.family.id}/show"
  else
    @notice = "Incorrect password"
    erb :"/families/edit"
  end
end