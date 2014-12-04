get '/families/new' do
  require_user
  erb :'/families/new'
end

get '/families/:family_id/show' do
  require_user
  authenticate_family_access(params[:family_id])
  @family = current_family
  @news_feed = []
  @family.posts.each { |post| @news_feed << post }
  @family.polls.each { |poll| @news_feed << poll }
  @family.photos.each { |photo| @news_feed << photo }
  @family.albums.each { |album| @news_feed << album }
  @news_feed.sort_by!(&:updated_at).reverse!
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
  @family = current_family
  erb :'/families/edit'
end

post '/families/new' do
  require_user
  family = Family.new(params[:family])
  if family.save
    family.users << current_user
    family.password = current_family.id
    family.save
    redirect "/families/#{current_family.id}/create?key=#{family.password}"
  else
    @notice = "Something went wrong, please try again"
    erb :'/families/new'
  end
end

put '/families/:family_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  if current_user.authenticate(params[:user][:password])
    if current_family.update_attributes(params[:family])
      redirect "/families/#{current_family.id}/show?notice=family%20settings%20updated"
    else
      redirect "/families/#{current_family.id}/show?notice=family%20setting%20failed%20to%20update"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=incorrect%20password"
  end
end