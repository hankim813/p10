helpers do
	def current_user_voted_in(poll)
		# if you are one of any of a given option's backers, this should return true
		poll.options.each do |option| 
			option.backers.each do |vote| 
				vote.backer == current_user ? (return vote) : next
			end
		end
		false
	end
end