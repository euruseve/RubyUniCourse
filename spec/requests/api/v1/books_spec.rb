require 'rails_helper'

RSpec.describe 'Api::V1::Books', type: :request do
  # Створюємо тестові дані
  let!(:author) { create(:author, name: 'George Orwell') }
  let!(:books) { create_list(:book, 15, author: author) }
  let!(:book_without_author) { create(:book, :without_author, title: 'Unknown Book') }

  describe 'GET /api/v1/books' do
    context 'without parameters' do
      before { get '/api/v1/books' }

      it 'returns status 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns JSON' do
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'returns books array' do
        json = JSON.parse(response.body)
        expect(json).to have_key('books')
        expect(json['books']).to be_an(Array)
      end

      it 'returns pagination metadata' do
        json = JSON.parse(response.body)
        expect(json).to have_key('pagination')
        expect(json['pagination']).to include(
          'current_page',
          'total_pages',
          'total_count',
          'per_page'
        )
      end

      it 'returns default 10 books per page' do
        json = JSON.parse(response.body)
        expect(json['books'].length).to eq(10)
      end
    end

    context 'with pagination parameters' do
      before { get '/api/v1/books', params: { page: 2, per_page: 5 } }

      it 'returns correct number of books' do
        json = JSON.parse(response.body)
        expect(json['books'].length).to eq(5)
      end

      it 'returns correct page number' do
        json = JSON.parse(response.body)
        expect(json['pagination']['current_page']).to eq(2)
      end
    end

    context 'with title filter' do
      let!(:specific_book) { create(:book, title: 'Specific Title Test', author: author) }

      before { get '/api/v1/books', params: { title: 'Specific' } }

      it 'returns filtered books' do
        json = JSON.parse(response.body)
        expect(json['books'].length).to be >= 1
        expect(json['books'].first['title']).to include('Specific')
      end
    end

    context 'with author_id filter' do
      let!(:another_author) { create(:author, name: 'Another Author') }
      let!(:another_book) { create(:book, author: another_author) }

      before { get '/api/v1/books', params: { author_id: another_author.id } }

      it 'returns books by specific author' do
        json = JSON.parse(response.body)
        json['books'].each do |book|
          expect(book['author']['id']).to eq(another_author.id)
        end
      end
    end

    context 'with invalid per_page (security)' do
      before { get '/api/v1/books', params: { per_page: 1000 } }

      it 'limits results to 100' do
        json = JSON.parse(response.body)
        expect(json['pagination']['per_page']).to be <= 100
      end
    end
  end

  describe 'GET /api/v1/books/:id' do
    let(:book) { books.first }

    context 'when book exists' do
      before { get "/api/v1/books/#{book.id}" }

      it 'returns status 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the book' do
        json = JSON.parse(response.body)
        expect(json).to have_key('book')
        expect(json['book']['id']).to eq(book.id)
        expect(json['book']['title']).to eq(book.title)
      end

      it 'includes author information' do
        json = JSON.parse(response.body)
        expect(json['book']).to have_key('author')
        expect(json['book']['author']['name']).to eq(author.name)
      end
    end

    context 'when book does not exist' do
      before { get '/api/v1/books/99999' }

      it 'returns status 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        json = JSON.parse(response.body)
        expect(json).to have_key('error')
        expect(json['error']).to eq('Record not found')
      end
    end

    context 'when book has no author' do
      before { get "/api/v1/books/#{book_without_author.id}" }

      it 'returns book with null author' do
        json = JSON.parse(response.body)
        expect(json['book']['author']).to be_nil
      end
    end
  end
end
