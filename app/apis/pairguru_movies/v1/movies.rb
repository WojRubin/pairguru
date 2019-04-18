module PairguruMovies
  module V1
    class Movies < Client
    	attr_reader :title, :id, :plot, :rating, :poster

    	def initialize(title)
    		obj = search_by_title(title)
    		if obj['message'] != "Couldn't find Movie"
			    @id = obj["data"]["id"]
			    @title = obj["data"]["attributes"]["title"]
			    @rating =obj["data"]["attributes"]["rating"]
			    @plot = obj["data"]["attributes"]["plot"]
			    @poster = obj["data"]["attributes"]["poster"]
		  	end
  		end

	    def search_by_title title
	      request(
	        http_method: :get,
	        endpoint: "#{title}"
	      )
	    end

	    def attributes
    		{'title' => nil, 'id' => nil, 'plot' => nil, 'rating' => nil, 'poster'=> nil}
  		end
	  end	
  end
end