class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :body, :movie_id
end
