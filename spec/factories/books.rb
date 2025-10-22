# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  author      :string
#  cover_data  :text
#  description :text
#  title       :string
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => authors.id)
#
FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    year { rand(1900..2030) }
    description { Faker::Lorem.paragraph }

    # Асоціація з автором (опціонально)
    trait :with_author do
      association :author
    end

    trait :without_author do
      author { nil }
    end
  end
end
