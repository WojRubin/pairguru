class CommentersController < ApplicationController

	# top commenters this week.
	# It should have 10 users that have the most comments in last week (from 7 days ago to now).
	def index
    @commenters = User.joins(:comments).where(created_at: 1.week.ago..DateTime.now).select("users.id,users.name, COUNT(comments.id) as comments_count, 'comments.created_at'").group("users.id").order('comments_count DESC').limit(10)
  end
end
