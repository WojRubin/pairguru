class Comment < ApplicationRecord
	belongs_to :movie
	belongs_to :user, optional: true
	
	validates_presence_of :body

	validate :maximum_comments

	def maximum_comments
    errors.add(:comments, 'too many comments for one movie') if (self.movie && self.movie.comments.where(user: self.user).count > 0)
  end
end
