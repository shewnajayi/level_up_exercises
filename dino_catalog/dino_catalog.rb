require 'csv'

class DinosaurCatalog
  def initialize
    @dinosaurs = CSV.read(File.dirname(__FILE__) + '/dinodex.csv')
    #add african dinosaurs to the list of dinosaurs
    african_dinos = CSV.read(File.dirname(__FILE__) + '/african_dinosaur_export.csv')
    african_dinos.shift() #remove the headers from the african_dinosaur_export csv file
    african_dinos.each do |row|
      @dinosaurs << row #remove all blank fields
    end
    return @dinosaurs
  end

  def singleFilter(key)
  	#convert search key to lowercase
  	key.downcase!
  	filtered_dinosaurs = []
  	@dinosaurs.each do |dinosaur|
  		#convert elements in array to lower case for easier searching
  		dinosaur.map!{|dino| dino.downcase unless dino.nil?} 
  		filtered_dinosaurs << dinosaur unless !dinosaur.include?key
  	end
  	return filtered_dinosaurs
  end

  def chainedFilter(keys)
    if !keys.include?(',')
      puts "Please make sure you search items are separated with a comma"
    end
  	keys.include?(',')
    splitted_keys = keys.gsub(/\s*,\s/, ',').split(',') #removing whitespaces before and after comma
  	filtered_dinosaurs = []
  	@dinosaurs.each do |dinosaur|
  		#convert elements in array to lower case for easier searching
  		dinosaur.map!{|dino| dino.downcase unless dino.nil?} 
  		dinosaur.each do |e| 
  			filtered_dinosaurs << dinosaur unless !splitted_keys.include?e
  		end
  	end
    return filtered_dinosaurs.uniq
  end

  def filterBySize(size)
  	filtered_dinosaurs = []
  	if size == "big"
  		@dinosaurs.each do |dinosaur|
        filtered_dinosaurs << dinosaur unless dinosaur[4].to_i <= 2000
  	  end
  	elsif size == "small"
  		@dinosaurs.each do |dinosaur|
        if !(dinosaur[4].to_i > 2000 || dinosaur[4].to_i == 0)
				  filtered_dinosaurs << dinosaur
        end
			end
	  end
  	return filtered_dinosaurs
  end
end

my_dinosaur = DinosaurCatalog.new()
puts "Welcome to Dino Catalog!! We store information about dinasaurs! \n\n"
puts "What would you like to search for? Choose from the options" + 
     "Biped, Carnivore, period, size(big or small). " +
     "To chain filter enter 'chain filter'"


user_input = gets.chomp.downcase

case user_input
when "big"
  puts my_dinosaur.filterBySize(user_input)
when "small"
  puts my_dinosaur.filterBySize(user_input)
when "carnivore"
  puts my_dinosaur.singleFilter(user_input).size
when "chain filter"
  puts "Enter search items you would like to chain separated by a comma"
  filter_items = gets.chomp
  puts my_dinosaur.chainedFilter(filter_items)
when "biped"
  puts my_dinosaur.singleFilter(user_input)
else
  puts "Sorry that's an invalid selection, please look at the instruction."
end
    



# puts DinosaurCatalog.getDinosaurs.inspect
# puts DinosaurCatalog.filter("jurassic, carnivore").inspect
#puts DinosaurCatalog.filter("biped").inspect
# puts DinosaurCatalog.filterBySize("small").inspect