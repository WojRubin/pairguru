require "rails_helper"

describe "commenters", type: :request do

	let!(:movies) { create_list(:movie, 5) }
	let!(:user_with_5_comments) { create :user, password: 'password' }
	let!(:comments) { movies.each{|m| create( :comment, user_id: user_with_5_comments.id, movie_id: m.id )}}
	let!(:user_with_2_comments) { create :user, password: 'password' }
	let!(:comments2) { [2,3].each{|m| create( :comment, user_id: user_with_2_comments.id, movie_id: m )}}
	let!(:no_comment_user) { create :user, password: 'password' }

  describe "commenters list" do
    it "displays only users with comments" do
      visit "/commenters"
      expect(page).to have_selector("table tr", count: 2)
    end

    it "displays user with 5 comments above user with 2 comments" do
      visit "/commenters"
      tr_list = page.find_all(:css, 'tr')
      first_tr = tr_list[0]
      second_tr = tr_list[1]
      expect(first_tr).to have_css('td.name', text: user_with_5_comments.name )
      expect(second_tr).to have_css('td.name', text: user_with_2_comments.name )
    end

    it "not displays user without any comments" do
      visit "/commenters"
      expect(page).not_to have_content(no_comment_user.name)
    end
  end
end