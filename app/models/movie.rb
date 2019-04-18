# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre, counter_cache: true
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments


  def comments_for_this_user user
		comments = self.comments.where(user: user).first
	end

end
