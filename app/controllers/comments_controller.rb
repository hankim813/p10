get '/families/:family_id/users/:user_id/posts/:post_id/comments/:comment_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if @comment = current_family.comments.find_by(id: params[:comment_id])
    erb :'/comments/edit'
  else
    redirect "/families/#{current_user.family.id}/show?notice=comment%20not%20found"
  end
end

post '/families/:family_id/posts/:post_id/comments/new' do
  require_user
  authenticate_family_access(params[:family_id])
  comment = Comment.new(description: params[:description], user_id: current_user.id, post_id: params[:post_id])
  if comment.save
    redirect "/families/#{current_user.family.id}/show?notice=comment%20successfully%20created"
  else
    redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong"
  end
end

post '/families/:family_id/posts/:post_id/comments/:comment_id/reply' do
  require_user
  authenticate_family_access(params[:family_id])
  if comment = current_family.comments.find_by(id: params[:comment_id])
    if comment.parent_id.nil? # prevents nested replies
      reply = Comment.new(description: params[:description])
      if reply.save
        comment.replies << reply
        reply.update_attributes(user_id: current_user.id, post_id: comment.post.id)
        redirect "/families/#{current_user.family.id}/show?notice=reply%20successfully%20created"
      else
        redirect "/families/#{current_user.family.id}/show?notice=reply%20no%20save"
      end
    end
  else
    redirect "/families/#{current_user.family.id}/show?notice=comment%20not%20found"
  end
end

put '/families/:family_id/users/:user_id/posts/:post_id/comments/:comment_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if current_family.comments.find_by(id: params[:comment_id]).update_attribute(:description, params[:description])
    redirect "/families/#{current_user.family.id}/show?notice=comment%20successfully%20updated"
  else
    redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong"
  end
end

delete '/families/:family_id/users/:user_id/posts/:post_id/comments/:comment_id/delete' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if current_family.comments.find_by(id: params[:comment_id]).destroy
    redirect "/families/#{current_user.family.id}/show?notice=comment%20successfully%20deleted"
  else
    redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong"
  end
end