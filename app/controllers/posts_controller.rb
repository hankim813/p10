get '/families/:family_id/posts/new' do
  require_user
  erb :'/posts/new'
end

get '/families/:family_id/posts/:post_id/show' do
  require_user
  authenticate_family_access(params[:family_id])
  if @post = Post.find_by(id: params[:post_id])
    erb :'/posts/show'
  else
    redirect "/families/#{current_user.family.id}/show?notice=post%20not%20found"
    return
  end
end

get '/families/:family_id/posts/:post_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  if @post = Post.find_by(id: params[:post_id])
    erb :'/posts/edit'
  else
    redirect "/families/#{current_user.family.id}/show?notice=post%20not%20found"
    return
  end
end

post '/posts/new' do
  require_user
  html = auto_embed_youtube(auto_embed_links(params[:description]))
  post = Post.new(description: params[:description], parsed_html: html)
  if post.save
    current_user.posts << post
    if tag = Tag.find_by(word: params[:tag_word].downcase)
      post.tags << tag
      redirect "/families/#{current_user.family.id}/show?notice=post%20successfully%20created"
    elsif params[:tag_word].empty?
      redirect "/families/#{current_user.family.id}/show?notice=post%20successfully%20created"
    else
      tag = Tag.new(word: params[:tag_word].downcase)
      if tag.save
        current_user.tags << tag
        post.tags << tag
        redirect "/families/#{current_user.family.id}/show?notice=post%20successfully%20created"
      else
      redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong%20with%20the%20tag"
      end
    end
  else
    redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong%20with%20the%20post"
  end
end

delete '/families/:family_id/posts/:post_id/delete' do
  require_user
  authenticate_family_access(params[:family_id])
  if Post.find_by(id: params[:post_id]).destroy
    redirect "/families/#{current_user.family.id}/show?notice=post%20destroyed"
  else
    redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong"
  end
end

put '/families/:family_id/posts/:post_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  if post = Post.find_by(id: params[:post_id])
    html = auto_embed_youtube(auto_embed_links(params[:description]))
    if post.update_attributes(description: params[:description], parsed_html: html)
      redirect "/families/#{current_user.family.id}/show?notice=post%20edited"
    else
      redirect "/families/#{current_user.family.id}/show?notice=something%20went%20wrong"
    end
  end
end