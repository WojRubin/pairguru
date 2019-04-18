class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title
  belongs_to :genre, if: :is_genre

  def is_genre
  	scope[:options] == 'genre'
  end
end
