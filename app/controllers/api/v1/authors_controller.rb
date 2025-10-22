module Api
  module V1
    class AuthorsController < BaseController
      # GET /api/v1/authors
      def index
        @authors = Author.includes(:books).all

        # Фільтр по імені
        @authors = @authors.where('name ILIKE ?', "%#{params[:name]}%") if params[:name].present?

        # Фільтр по активності
        @authors = @authors.where(active: params[:active]) if params[:active].present?

        # Сортування
        @authors = @authors.order(:name)

        # Пагінація
        @authors = @authors.page(page_params[:page]).per(page_params[:per_page])

        # Метадані пагінації
        @pagination = {
          current_page: @authors.current_page,
          next_page: @authors.next_page,
          prev_page: @authors.prev_page,
          total_pages: @authors.total_pages,
          total_count: @authors.total_count,
          per_page: page_params[:per_page]
        }
      end

      # GET /api/v1/authors/:id
      def show
        @author = Author.includes(:books).find(params[:id])
      end
    end
  end
end
