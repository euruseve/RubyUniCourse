# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Clearing existing data..."
Book.destroy_all
Author.destroy_all

puts "\n" + "="*50
puts "Creating Authors..."
puts "="*50

authors_data = [
  {
    name: "Harper Lee",
    bio: "Harper Lee was an American novelist best known for her 1960 novel To Kill a Mockingbird.",
    active: true
  },
  {
    name: "George Orwell",
    bio: "Eric Arthur Blair, known by his pen name George Orwell, was an English novelist and essayist.",
    active: true
  },
  {
    name: "Jane Austen",
    bio: "Jane Austen was an English novelist known primarily for her six major novels.",
    active: true
  },
  {
    name: "F. Scott Fitzgerald",
    bio: "Francis Scott Key Fitzgerald was an American novelist and short story writer.",
    active: false  # Неактивний автор
  },
  {
    name: "J.K. Rowling",
    bio: "Joanne Rowling, better known by her pen name J.K. Rowling, is a British author and philanthropist.",
    active: true
  }
]

authors = authors_data.map do |author_data|
  author = Author.create!(author_data)
  status = author.active ? "✓ Active" : "✗ Inactive"
  puts "#{status} - Created author: #{author.name}"
  author
end

puts "\n" + "="*50
puts "Creating Books..."
puts "="*50

Book.create!([
  {
    title: "To Kill a Mockingbird",
    author: authors[0],
    year: 1960,
    description: "A gripping tale of racial injustice and childhood innocence in the American South."
  },
  {
    title: "Go Set a Watchman",
    author: authors[0],
    year: 2015,
    description: "A novel set 20 years after To Kill a Mockingbird, featuring Scout Finch as an adult."
  }
])
puts "  → Created 2 books for #{authors[0].name}"

Book.create!([
  {
    title: "1984",
    author: authors[1],
    year: 1949,
    description: "A dystopian social science fiction novel and cautionary tale about totalitarianism."
  },
  {
    title: "Animal Farm",
    author: authors[1],
    year: 1945,
    description: "An allegorical novella reflecting events leading up to the Russian Revolution."
  },
  {
    title: "Homage to Catalonia",
    author: authors[1],
    year: 1938,
    description: "Orwell's personal account of his experiences in the Spanish Civil War."
  }
])
puts "  → Created 3 books for #{authors[1].name}"

Book.create!([
  {
    title: "Pride and Prejudice",
    author: authors[2],
    year: 1813,
    description: "A romantic novel of manners that critiques the British landed gentry."
  },
  {
    title: "Sense and Sensibility",
    author: authors[2],
    year: 1811,
    description: "A novel about the Dashwood sisters and their search for love and security."
  }
])
puts "  → Created 2 books for #{authors[2].name}"

puts "  → Skipped books for #{authors[3].name} (inactive author)"

Book.create!([
  {
    title: "Harry Potter and the Philosopher's Stone",
    author: authors[4],
    year: 1997,
    description: "The first novel in the Harry Potter series."
  },
  {
    title: "Harry Potter and the Chamber of Secrets",
    author: authors[4],
    year: 1998,
    description: "The second novel in the Harry Potter series."
  },
  {
    title: "Harry Potter and the Prisoner of Azkaban",
    author: authors[4],
    year: 1999,
    description: "The third novel in the Harry Potter series."
  }
])
puts "  → Created 3 books for #{authors[4].name}"

# Створення кількох книг без автора (для тестування optional: true)
Book.create!([
  {
    title: "Unknown Masterpiece",
    author: nil,
    year: 2020,
    description: "A mysterious book with no known author."
  }
])
puts "  → Created 1 book without author"

puts "\n" + "="*50
puts "Summary:"
puts "="*50
puts "Total Authors: #{Author.count} (#{Author.active.count} active, #{Author.where(active: false).count} inactive)"
puts "Total Books: #{Book.count}"
puts "Active authors with books: #{Author.active.joins(:books).distinct.count}"
puts "="*50
puts "\n Seeds completed successfully!"