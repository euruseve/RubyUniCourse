module Api
  module V1
    class BooksController < BaseController
      # GET /api/v1/books
      def index
        @books = Book.includes(:author).all

        # Фільтр по назві
        @books = @books.where('title ILIKE ?', "%#{params[:title]}%") if params[:title].present?

        # Фільтр по автору
        @books = @books.where(author_id: params[:author_id]) if params[:author_id].present?

        # Сортування
        @books = @books.order(created_at: :desc)

        # Пагінація
        @books = @books.page(page_params[:page]).per(page_params[:per_page])

        # Метадані пагінації
        @pagination = {
          current_page: @books.current_page,
          next_page: @books.next_page,
          prev_page: @books.prev_page,
          total_pages: @books.total_pages,
          total_count: @books.total_count,
          per_page: page_params[:per_page]
        }
      end

      # GET /api/v1/books/:id
      def show
        @book = Book.includes(:author).find(params[:id])
      end
    end
  end
end
