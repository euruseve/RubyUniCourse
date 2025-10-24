module Types
  class BookType < Types::BaseObject
    description 'A book in the library'

    field :id, ID, null: false
    field :title, String, null: false
    field :year, Integer, null: false
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :author, Types::AuthorType, null: true

    field :cover_url, String, null: true

    def cover_url
      object.cover_url if object.respond_to?(:cover_url)
    end
  end
end
