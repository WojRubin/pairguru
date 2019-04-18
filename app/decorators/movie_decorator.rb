class MovieDecorator < Draper::Decorator
  decorates_association :comments
  delegate_all
  decorates :movie
  attr_reader :pairguru_api

  def initialize(object, options = {})
    @pairguru_api = PairguruMovies::V1::Movies.new(URI.encode(object.title))
    super(object, options = {})
  end

  def linked_title
    handle_none object.title do
      h.content_tag :h4 do
      	h.link_to object.title, h.movie_path(object)
      end
    end
  end

  def linked_genre
    handle_none object.genre.name do
    	h.content_tag :strong do
    		h.link_to object.genre.name, h.movies_genre_path(object.genre)
    	end
    end
	end

	def released_at
    handle_none movie.released_at do
		  ' (' + movie.released_at.strftime("%B %d, %Y") + ')'
    end
	end

  def cover
  	handle_none pairguru_api.poster do
      "https://pairguru-api.herokuapp.com" +  pairguru_api.poster
    end
  end

  def send_details_link
    h.content_tag :span do
    	h.link_to 'Email me details about this movie', h.send_info_movie_url(object), class: 'btn btn-sm btn-default'
    end
  end

  def plot
    handle_none pairguru_api.plot do
      h.content_tag :p do
        pairguru_api.plot
      end
    end
  end

  def rating
    handle_none pairguru_api.rating do
      h.content_tag :p do
        pairguru_api.rating.to_s
      end
    end
  end

private
  
  def handle_none(value)
    if value.present?
      yield
    else
      h.content_tag :span, "None given", class: "none"
    end
  end
end
