puts 'Clearing movies'
Movie.destroy_all

puts 'Creating new movies'

require 'json'
require 'open-uri'

url = 'https://tmdb.lewagon.com/movie/top_rated'
movie_serialized = URI.open(url).read
movie_list = JSON.parse(movie_serialized)

movies = movie_list['results'].first(20)

movies.each do |movie|
  Movie.create(title: movie['title'], overview: movie['overview'],
               poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
               rating: movie['vote_average'])
end
