class PopulateGenreMoviesCount < ActiveRecord::Migration[5.2]
  def up
    Genre.find_each do |genre|
      Genre.reset_counters(genre.id, :movies)
    end
  end
end


