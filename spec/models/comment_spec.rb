require 'rails_helper'

RSpec.describe Comment, type: :model do
	let(:movie){ create(:movie) }
	let(:comment){ create(:comment, movie_id: movie.id, user_id:1) }
	let(:comment_by_one_user){ create(:comment, movie_id: movie.id, user_id:1) }
	let(:comment_by_second_user){ create(:comment, movie_id: movie.id, user_id:2) }

  describe '#body' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe '#maximum_comments validator' do
  	it '#only one comment for one movie by one user is valid' do
  		comment1 = Comment.create(user_id: 1, movie_id: 1, body: 'tekst')
	  	comment2 = Comment.create(user_id: 1, movie_id: 1, body: 'tekst')
	  	comment2.valid?
	  	expect(comment2).to_not be_valid
  	end

  	it '#two comments for one movie by two users is valid' do
	  	comment1, comment2 = comment, comment_by_second_user

	    expect(comment2).to be_valid
  	end
  end

end
