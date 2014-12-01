get '/comments/:comment_id/edit' do
  require_user
  @comment = Comment.find(params[:comment_id])
  erb :'/comments/edit'
end

post '/comments/new' do
  require_user
  post = Post.find(params[:post_id])
  comment = Comment.new(description: params[:description])
  if comment.save
    post.comments << comment
    current_user.comments << comment
    redirect "/families/#{post.user.family.id}/show?notice=comment%20successfully%20created"
  else
    redirect "/families/#{post.user.family.id}/show?notice=something%20went%20wrong"
  end
end

post '/comments/:comment_id/reply' do
  require_user
  comment = Comment.find(params[:comment_id])
  if comment.parent_id.nil? # prevents nested replies
    reply = Comment.new(description: params[:description])
    if reply.save
      comment.replies << reply
      reply.update_attributes(user_id: current_user.id, post_id: comment.post.id)
      redirect "/families/#{reply.user.family.id}/show?notice=reply%20successfully%20created"
    else
      redirect "/families/#{reply.user.family.id}/show?notice=something%20went%20wrong"
    end
  end
end

put '/comments/:comment_id/edit' do
  require_user
  comment = Comment.find(params[:comment_id])
  if comment.update_attribute(:description, params[:description])
    redirect "/families/#{comment.user.family.id}/show?notice=comment%20successfully%20updated"
  else
    redirect "/families/#{comment.user.family.id}/show?notice=something%20went%20wrong"
  end
end

delete '/comments/:comment_id/delete' do
  require_user
  comment = Comment.find(params[:comment_id])
  if comment.destroy
    redirect "/families/#{comment.user.family.id}/show?notice=comment%20successfully%20deleted"
  else
    redirect "/families/#{comment.user.family.id}/show?notice=something%20went%20wrong"
  end
end