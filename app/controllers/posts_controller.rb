get '/families/:family_id/posts/new' do
  require_user
  authenticate_family_access(params[:family_id])
  erb :'/posts/new'
end

get '/families/:family_id/posts/:post_id/show' do
  require_user
  authenticate_family_access(params[:family_id])
  if @post = current_family.posts.find_by(id: params[:post_id])
    erb :'/posts/show'
  else
    redirect "/families/#{current_family.id}/show?notice=post%20not%20found"
  end
end

get '/families/:family_id/users/:user_id/posts/:post_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if @post = current_family.posts.find_by(id: params[:post_id])
    erb :'/posts/edit'
  else
    redirect "/families/#{current_family.id}/show?notice=post%20not%20found"
  end
end

post '/posts/new' do
  require_user
  html = auto_embed_youtube(auto_embed_links(params[:description]))
  post = Post.new(description: params[:description], parsed_html: html, user_id: current_user.id)
  if post.save
    params[:tags] ? (tags = params[:tags].split(",").map(&:strip)) : (redirect "/families/#{current_family.id}/show?notice=post%20successfully%20created")
    tags.each do |tag_word|
      if tag = current_family.tags.find_by(word: tag_word.downcase)
        post.tags << tag
      else
        tag = Tag.new(word: tag_word.downcase)
        if tag.save
          current_user.tags << tag
          post.tags << tag
        else
          redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong%20with%20the%20tag"
        end
      end
    end
    redirect "/families/#{current_family.id}/show?notice=post%20successfully%20created"
  else
    redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong%20with%20the%20post"
  end
end

delete '/families/:family_id/users/:user_id/posts/:post_id/delete' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if current_family.posts.find_by(id: params[:post_id]).destroy
    redirect "/families/#{current_family.id}/show?notice=post%20destroyed"
  else
    redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
  end
end

put '/families/:family_id/users/:user_id/posts/:post_id/edit' do
  require_user
  authenticate_family_access(params[:family_id])
  authenticate_user_access(params[:user_id])
  if post = current_family.posts.find_by(id: params[:post_id])
    html = auto_embed_youtube(auto_embed_links(params[:description]))
    if post.update_attributes(description: params[:description], parsed_html: html)
      redirect "/families/#{current_family.id}/show?notice=post%20edited"
    else
      redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
    end
  end
end