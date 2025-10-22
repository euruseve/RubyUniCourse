require 'rails_helper'

RSpec.describe 'Api::V1::Authors', type: :request do
  let!(:active_authors) { create_list(:author, 5, :with_books, active: true) }
  let!(:inactive_authors) { create_list(:author, 3, :inactive) }

  describe 'GET /api/v1/authors' do
    context 'without parameters' do
      before { get '/api/v1/authors' }

      it 'returns status 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns JSON' do
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'returns authors array' do
        json = JSON.parse(response.body)
        expect(json).to have_key('authors')
        expect(json['authors']).to be_an(Array)
      end

      it 'includes books_count' do
        json = JSON.parse(response.body)
        expect(json['authors']).to all(have_key('books_count'))
      end
    end

    context 'with active filter' do
      before { get '/api/v1/authors', params: { active: true } }

      it 'returns only active authors' do
        json = JSON.parse(response.body)
        json['authors'].each do |author|
          expect(author['active']).to be true
        end
      end
    end

    context 'with name filter' do
      let!(:specific_author) { create(:author, name: 'Specific Name Test') }

      before { get '/api/v1/authors', params: { name: 'Specific' } }

      it 'returns filtered authors' do
        json = JSON.parse(response.body)
        expect(json['authors'].length).to be >= 1
        expect(json['authors'].first['name']).to include('Specific')
      end
    end

    context 'with pagination' do
      before { get '/api/v1/authors', params: { page: 1, per_page: 3 } }

      it 'returns correct number of authors' do
        json = JSON.parse(response.body)
        expect(json['authors'].length).to eq(3)
      end
    end
  end

  describe 'GET /api/v1/authors/:id' do
    let(:author) { active_authors.first }

    context 'when author exists' do
      before { get "/api/v1/authors/#{author.id}" }

      it 'returns status 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the author' do
        json = JSON.parse(response.body)
        expect(json).to have_key('author')
        expect(json['author']['id']).to eq(author.id)
      end

      it 'includes books array' do
        json = JSON.parse(response.body)
        expect(json['author']).to have_key('books')
        expect(json['author']['books']).to be_an(Array)
      end

      it 'includes books_count' do
        json = JSON.parse(response.body)
        expect(json['author']['books_count']).to eq(author.books.count)
      end
    end

    context 'when author does not exist' do
      before { get '/api/v1/authors/99999' }

      it 'returns status 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        json = JSON.parse(response.body)
        expect(json['error']).to eq('Record not found')
      end
    end
  end
end
