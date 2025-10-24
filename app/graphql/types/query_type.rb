module Types
  class QueryType < Types::BaseObject
    description 'The query root of this schema'

    field :books, [Types::BookType], null: false,
                                     description: 'Get all books' do
      argument :limit, Integer, required: false, default_value: 100
      argument :offset, Integer, required: false, default_value: 0
      argument :title, String, required: false
      argument :year, Integer, required: false
    end

    def books(limit:, offset:, title: nil, year: nil)
      books = Book.includes(:author).all

      books = books.where('title ILIKE ?', "%#{title}%") if title.present?

      books = books.where(year: year) if year.present?

      books.limit(limit).offset(offset)
    end

    field :book, Types::BookType, null: true,
                                  description: 'Find a book by ID' do
      argument :id, ID, required: true
    end

    def book(id:)
      Book.find_by(id: id)
    end

    field :authors, [Types::AuthorType], null: false,
                                         description: 'Get all authors' do
      argument :limit, Integer, required: false, default_value: 100
      argument :offset, Integer, required: false, default_value: 0
      argument :active, Boolean, required: false
      argument :name, String, required: false
    end

    def authors(limit:, offset:, active: nil, name: nil)
      authors = Author.includes(:books).all

      authors = authors.where(active: active) unless active.nil?

      authors = authors.where('name ILIKE ?', "%#{name}%") if name.present?

      authors.order(:name).limit(limit).offset(offset)
    end

    field :author, Types::AuthorType, null: true,
                                      description: 'Find an author by ID' do
      argument :id, ID, required: true
    end

    def author(id:)
      Author.find_by(id: id)
    end

    field :books_count, Integer, null: false,
                                 description: 'Total number of books'

    def books_count
      Book.count
    end

    field :authors_count, Integer, null: false,
                                   description: 'Total number of authors'

    def authors_count
      Author.count
    end

    field :books_paginated, Types::BooksPaginatedType, null: false do
      argument :page, Integer, required: false, default_value: 1
      argument :per_page, Integer, required: false, default_value: 10
    end

    def books_paginated(page:, per_page:)
      books = Book.includes(:author).page(page).per(per_page)

      {
        books: books,
        total_count: Book.count,
        current_page: page,
        per_page: per_page,
        total_pages: books.total_pages,
        has_next_page: books.next_page.present?,
        has_previous_page: books.prev_page.present?
      }
    end
  end
end
