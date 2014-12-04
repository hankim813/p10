get '/tags/search' do
	@family = current_family
	if tags_to_search = params[:tags].split(",").map(&:strip)
		@news_feed = []
		found_tags = []
		tags_to_search.each { |tag| found_tags << current_family.tags.find_by(word: tag) }
		found_tags.each do |tag| 
			@news_feed << tag.posts
			@news_feed << tag.polls
			@news_feed << tag.photos
			@news_feed << tag.albums
		end
		@news_feed.flatten!.sort_by!(&:updated_at).reverse!
		
		@news_feed.count == 1 ? (@notice = "Found 1 result") : (@notice = "Found #{@news_feed.count} results")
		erb :"/tags/show" 
	else
		redirect "/families/#{current_family.id}/show?notice=no%20results%20found"
	end
end