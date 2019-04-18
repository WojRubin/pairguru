class TitleBracketsValidator < ActiveModel::Validator
	CHECKED_BRACKETS = { '('=>')','['=>']','{'=>'}' }

  def validate(record)
  	object = record.title
  	counter = set_counter object

    object.chars.each_with_index do |variable,i|
	  	CHECKED_BRACKETS.each do |k,v|
	  		counter[variable] += 1
	  		check_between object ,variable, i, k , v, record
	  	end
		end
		CHECKED_BRACKETS.each do |k,v|
			record.errors.add(:title_brackets, "not too much opening brackets") if (counter[k] - counter[v] != 0)
		end
  end

  def check_between object, variable, i, bracket_opening, bracket_closing, record
		nested_counter = set_counter object

 		if variable == bracket_opening
 			to = object.slice(i+1, object.length+1).index(bracket_closing)
			if to
				substr = object.slice(i+1,to)
				substr.chars.each_with_index do |var|
		    	nested_counter[var] += 1
		 		end
		 		record.errors.add(:title_brackets, "empty brackets") if substr.length < 1 || substr.blank?

		 		CHECKED_BRACKETS.each do |k,v|
			 		record.errors.add(:title_brackets, "with nested matching brackets") if (nested_counter[k] - nested_counter[v] != 0)
			 	end
			else
				record.errors.add(:title_brackets, "with not closed brackets")
			end
		end
  end

  def set_counter object
  	counter = {}
  	object.chars.each{|n| counter[n] = 0}
  	CHECKED_BRACKETS.each do |k,v|
  		counter[k], counter[v] = 0, 0
  	end
  	counter
  end
end
