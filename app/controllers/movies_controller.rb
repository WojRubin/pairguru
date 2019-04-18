class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  decorates_assigned :movie, :movies, :comment, :comments

  def index
    @movies = Movie.all.includes(:genre).group(:title).order(:id).decorate
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.all
    @comment = @movie.comments.build(movie_params)
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

private
  def movie_params
    params.permit(comment_attributes: [:body, :movie_id])
  end
end
