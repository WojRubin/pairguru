class GenreSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :movies_count, if: :is_genre?

  has_many :movies

  def is_genre?
  	scope[:options] == 'genre'
  end

  def movies_count
   object.movies_count
  end
end
