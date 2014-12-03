get '/families/new' do
  require_user
  erb :'/families/new'
end

get '/families/:family_id/show' do
  require_user
  authenticate_family_access(params[:family_id])
  @family = Family.find_by(id: params[:family_id])
  @posts = @family.posts.reverse
  @polls = @family.polls
  @notice = params[:notice]
  erb :"/families/show"
end

get '/families/:family_id/create' do
  @key = params[:key]
  erb :"/families/create"
end

get '/families/:family_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  if @family = Family.find_by(id: params[:family_id])
    erb :'/families/edit'
  else
    redirect "/families/#{current_user.family.id}/show?notice=family%20not%20found"
    return
  end
end

post '/families/new' do
  require_user
  family = Family.new(params[:family])
  if family.save
    family.users << current_user
    family.password = current_user.family.id
    family.save
    redirect "/families/#{current_user.family.id}/create?key=#{family.password}"
    return
  else
    @notice = "Something went wrong, please try again"
    erb :'/families/new'
  end
end

put '/families/:family_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  if @family = Family.find_by(id: params[:family_id]) 
    if current_user.authenticate(params[:user][:password])
      if @family.update_attributes(params[:family])
        redirect "/families/#{current_user.family.id}/show?notice=family%20settings%20updated"
        return
      else
        redirect "/families/#{current_user.family.id}/show?notice=family%20setting%20failed%20to%20update"
      end
    else
      redirect "/families/#{current_user.family.id}/show?notice=family%20not%20found"
    end
  else
    @notice = "Incorrect password"
    erb :"/families/edit"
  end
end