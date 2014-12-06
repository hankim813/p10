get '/tags/search' do
	@family = current_family
	if tags_to_search = params[:tags].split(",").map(&:strip)
		@news_feed = []
		found_tags = []
		tags_to_search.each { |tag| found_tags << current_family.tags.find_by(word: tag) }
		unless found_tags[0] == nil
			found_tags.each do |tag| 
				@news_feed << tag.posts
				@news_feed << tag.polls
				@news_feed << tag.photos
				@news_feed << tag.albums
			end
			@news_feed.flatten!.sort_by!(&:updated_at).reverse!
		end
		if @news_feed.count == 1 
			@notice = "found 1 result"
			erb :"/tags/show", anchor: "news-feed-anchor"
		else
			@notice = "found #{@news_feed.count} results."
			erb :"/tags/show", anchor: "news-feed-anchor"
		end
	else
		redirect "/families/#{current_family.id}/show?notice=no%20results%20found#news-feed-anchor"
	end
end

get '/families/:family_id/tags/search/show' do
	require_user
	if authenticate_family_access(params[:family_id])
	  @family = current_family
	  @news_feed = []
	  @family.posts.each { |post| @news_feed << post }
	  @family.polls.each { |poll| @news_feed << poll }
	  @family.photos.each { |photo| @news_feed << photo }
	  @family.albums.each { |album| @news_feed << album }
	  @news_feed.sort_by!(&:updated_at).reverse!
	  @notice = params[:notice]
	  erb :"/families/show"
	else
	  redirect "/families/#{current_family.id}/show?notice=that%20is%20not%20your%20family#news-feed-anchor"
	end
end