get '/posts/new' do
  erb :'/posts/new'
end

get '/posts/:post_id/edit' do
  @post = Post.find(params[:post_id])
  erb :'/posts/edit'
end

post '/posts/new' do
  parsed_html = auto_embed_youtube(params[:description])
  current_user.posts << Post.create(description: parsed_html)
  redirect "/families/#{current_user.family.id}/show"
end

delete '/posts/:post_id/delete' do
  post = Post.find(params[:post_id])
  user = post.user
  if post.destroy
    redirect "/families/#{user.family.id}/show?notice=post%20destroyed"
  else
    redirect "/families/#{user.family.id}/show?notice=something%20went%20wrong"
  end
end

put '/posts/:post_id/edit' do
  post = Post.find(params[:post_id])
  user = post.user
  if post.update_attribute(:description, params[:description])
    redirect "/families/#{user.family.id}/show?notice=post%20edited"
  else
    redirect "/families/#{user.family.id}/show?notice=something%20went%20wrong"
  end
end