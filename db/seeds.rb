# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Clearing existing books..."
Book.destroy_all

puts "Creating sci-fi books..."

books = [
  {
    title: "Dune",
    author: "Frank Herbert",
    year: 1965,
    description: "Epic science fiction novel set in the distant future amidst a feudal interstellar society, focusing on the desert planet Arrakis."
  },
  {
    title: "Foundation",
    author: "Isaac Asimov",
    year: 1951,
    description: "First novel in the Foundation series, exploring the collapse and rebirth of a galactic empire through psychohistory."
  },
  {
    title: "Neuromancer",
    author: "William Gibson",
    year: 1984,
    description: "Groundbreaking cyberpunk novel that coined the term 'cyberspace' and defined the cyberpunk genre."
  },
  {
    title: "The Left Hand of Darkness",
    author: "Ursula K. Le Guin",
    year: 1969,
    description: "Science fiction novel exploring themes of gender and sexuality on a planet where inhabitants can change gender."
  },
  {
    title: "Snow Crash",
    author: "Neal Stephenson",
    year: 1992,
    description: "Cyberpunk novel featuring a futuristic America where the government has largely collapsed and been replaced by corporate franchises."
  }
]

books.each do |book_data|
  Book.create!(book_data)
  puts "✓ Created: #{book_data[:title]} by #{book_data[:author]}"
end

puts "\n #{Book.count} books created successfully!"