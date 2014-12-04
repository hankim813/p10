get '/families/:family_id/users/:user_id/posts/:post_id/comments/:comment_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if @comment = current_family.comments.find_by(id: params[:comment_id])
    @family = current_family
    erb :'/comments/edit'
  else
    redirect "/families/#{current_family.id}/show?notice=comment%20not%20found"
  end
end

get '/families/:family_id/users/:user_id/polls/:poll_id/comments/:comment_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if @comment = current_family.comments.find_by(id: params[:comment_id])
    @family = current_family
    erb :'/comments/edit'
  else
    redirect "/families/#{current_family.id}/show?notice=comment%20not%20found"
  end
end

get '/families/:family_id/users/:user_id/photos/:photo_id/comments/:comment_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if @comment = current_family.comments.find_by(id: params[:comment_id])
    @family = current_family
    erb :'/comments/edit'
  else
    redirect "/families/#{current_family.id}/show?notice=comment%20not%20found"
  end
end

get '/families/:family_id/users/:user_id/albums/:album_id/comments/:comment_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if @comment = current_family.comments.find_by(id: params[:comment_id])
    @family = current_family
    erb :'/comments/edit'
  else
    redirect "/families/#{current_family.id}/show?notice=comment%20not%20found"
  end
end

post '/families/:family_id/posts/:post_id/comments/new' do
  require_user
  authenticate_family_access(params[:family_id])
  if post = current_family.posts.find_by(id: params[:post_id])
    if comment = post.comments.create(description: params[:description], user_id: current_user.id)
      redirect "/families/#{current_family.id}/show?notice=comment%20successfully%20created"
    else
      redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=post%20not%20found"
  end
end

post '/families/:family_id/polls/:poll_id/comments/new' do 
  require_user
  authenticate_family_access(params[:family_id])
  if poll = current_family.polls.find_by(id: params[:poll_id])
    if comment = poll.comments.create(description: params[:description], user_id: current_user.id)
      redirect "/families/#{current_family.id}/show?notice=comment%20successfully%20created"
    else
      redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=poll%20not%20found"
  end
end

post '/families/:family_id/photos/:photo_id/comments/new' do
  require_user
  authenticate_family_access(params[:family_id])
  if photo = current_family.photos.find_by(id: params[:photo_id])
    if comment = photo.comments.create(description: params[:description], user_id: current_user.id)
      redirect "/families/#{current_family.id}/show?notice=comment%20successfully%20created"
    else
      redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=photo%20not%20found"
  end
end

post '/families/:family_id/albums/:album_id/comments/new' do
  require_user
  authenticate_family_access(params[:family_id])
  if album = current_family.albums.find_by(id: params[:album_id])
    if comment = album.comments.create(description: params[:description], user_id: current_user.id)
      redirect "/families/#{current_family.id}/show?notice=comment%20successfully%20created"
    else
      redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=album%20not%20found"
  end
end

post '/families/:family_id/posts/:post_id/comments/:comment_id/reply' do
  require_user
  authenticate_family_access(params[:family_id])
  if comment = current_family.comments.find_by(id: params[:comment_id])
    if comment.parent_comment.nil? && reply = comment.replies.create(description: params[:description])
      redirect "/families/#{current_family.id}/show?notice=reply%20successfully%20created" if reply.update_attribute(:user_id, current_user.id) 
      return
    else
      redirect "/families/#{current_family.id}/show?notice=reply%20no%20save"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=comment%20not%20found"
  end
end

post '/families/:family_id/polls/:poll_id/comments/:comment_id/reply' do
  require_user
  authenticate_family_access(params[:family_id])
  if comment = current_family.comments.find_by(id: params[:comment_id])
    if comment.parent_comment.nil? && reply = comment.replies.create(description: params[:description])
      redirect "/families/#{current_family.id}/show?notice=reply%20successfully%20created" if reply.update_attribute(:user_id, current_user.id) 
      return
    else
      redirect "/families/#{current_family.id}/show?notice=reply%20no%20save"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=comment%20not%20found"
  end
end

post '/families/:family_id/photos/:photo_id/comments/:comment_id/reply' do
  require_user
  authenticate_family_access(params[:family_id])
  if comment = current_family.comments.find_by(id: params[:comment_id])
    if comment.parent_comment.nil? && reply = comment.replies.create(description: params[:description])
      redirect "/families/#{current_family.id}/show?notice=reply%20successfully%20created" if reply.update_attribute(:user_id, current_user.id) 
      return
    else
      redirect "/families/#{current_family.id}/show?notice=reply%20no%20save"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=comment%20not%20found"
  end
end

post '/families/:family_id/albums/:album_id/comments/:comment_id/reply' do
  require_user
  authenticate_family_access(params[:family_id])
  if comment = current_family.comments.find_by(id: params[:comment_id])
    if comment.parent_comment.nil? && reply = comment.replies.create(description: params[:description])
      redirect "/families/#{current_family.id}/show?notice=reply%20successfully%20created" if reply.update_attribute(:user_id, current_user.id) 
      return
    else
      redirect "/families/#{current_family.id}/show?notice=reply%20no%20save"
    end
  else
    redirect "/families/#{current_family.id}/show?notice=comment%20not%20found"
  end
end

put '/families/:family_id/users/:user_id/comments/:comment_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if current_family.comments.find_by(id: params[:comment_id]).update_attribute(:description, params[:description])
    redirect "/families/#{current_family.id}/show?notice=comment%20successfully%20updated"
  else
    redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
  end
end

delete '/families/:family_id/users/:user_id/posts/:post_id/comments/:comment_id/delete' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if current_family.comments.find_by(id: params[:comment_id]).destroy
    redirect "/families/#{current_family.id}/show?notice=comment%20successfully%20deleted"
  else
    redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
  end
end

delete '/families/:family_id/users/:user_id/polls/:poll_id/comments/:comment_id/delete' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if current_family.comments.find_by(id: params[:comment_id]).destroy
    redirect "/families/#{current_family.id}/show?notice=comment%20successfully%20deleted"
  else
    redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
  end
end

delete '/families/:family_id/users/:user_id/photos/:photo_id/comments/:comment_id/delete' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if current_family.comments.find_by(id: params[:comment_id]).destroy
    redirect "/families/#{current_family.id}/show?notice=comment%20successfully%20deleted"
  else
    redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
  end
end

delete '/families/:family_id/users/:user_id/albums/:album_id/comments/:comment_id/delete' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if current_family.comments.find_by(id: params[:comment_id]).destroy
    redirect "/families/#{current_family.id}/show?notice=comment%20successfully%20deleted"
  else
    redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
  end
end