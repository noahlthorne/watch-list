# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'
# the Le Wagon copy of the API
url = 'http://tmdb.lewagon.com/movie/top_rated'
rest_reponse = RestClient.get(url)
response = JSON.parse(rest_reponse.body)
puts "cleaning database...."
Movie.destroy_all
response['results'].each do |movie_hash|
  movie = Movie.new(
      title: movie_hash["title"],
      overview: movie_hash["overview"],
      poster_url: "https://image.tmdb.org/t/p/w500" + movie_hash["poster_path"],
      rating: movie_hash["vote_average"].to_i,
  ) 
  movie.save!
  puts "Created #{movie.title}! #{Movie.count} movies are in the database"
end
p "FINISHED SEEDING MOVIES WITH #{Movie.count} MOVIES!"