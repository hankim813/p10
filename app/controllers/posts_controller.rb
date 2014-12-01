get '/posts/new' do
  require_user
  erb :'/posts/new'
end

get '/posts/:post_id/show' do
  require_user
  @post = Post.find(params[:post_id])
  erb :'/posts/show'
end

get '/posts/:post_id/edit' do
  require_user
  @post = Post.find(params[:post_id])
  erb :'/posts/edit'
end

post '/posts/new' do
  require_user
  parsed_html = auto_embed_youtube(params[:description])
  post = Post.new(description: parsed_html)
  if post.save
    current_user.posts << post
    redirect "/families/#{current_user.family.id}/show?notice=post%20successfully%20created"
  else
    redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong"
  end
end

delete '/posts/:post_id/delete' do
  require_user
  post = Post.find(params[:post_id])
  user = post.user
  if post.destroy
    redirect "/families/#{user.family.id}/show?notice=post%20destroyed"
  else
    redirect "/families/#{user.family.id}/show?notice=something%20went%20wrong"
  end
end

put '/posts/:post_id/edit' do
  require_user
  post = Post.find(params[:post_id])
  user = post.user
  parsed_html = auto_embed_youtube(params[:description])
  if post.update_attribute(:description, parsed_html)
    redirect "/families/#{user.family.id}/show?notice=post%20edited"
  else
    redirect "/families/#{user.family.id}/show?notice=something%20went%20wrong"
  end
end