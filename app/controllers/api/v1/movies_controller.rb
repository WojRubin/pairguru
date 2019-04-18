module Api
  module V1
    class MoviesController < ApplicationController

      def index
        if params[:options] == 'genre'
          movies = Movie.includes(:genre).all.group(:title).order(:id)
        else
          movies = Movie.all.group(:title).order(:id)
        end
        render json: movies, scope: { options: params[:options] }
      end

      def show
        if params[:options] == 'genre'
          movie = Movie.find(params[:id])
        else
          movie = Movie.includes(:genre).find(params[:id])
        end
        render json: movie, scope: { options: params[:options] }
      end

      private
        def movie_params
          params.require(:champion).permit(:id, :title, :options)
        end
    end
  end
end