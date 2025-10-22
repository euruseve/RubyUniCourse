# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  bio        :text
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_authors_on_active  (active)
#  index_authors_on_name    (name)
#
FactoryBot.define do
  factory :author do
    name { Faker::Book.author }
    bio { Faker::Lorem.paragraph }
    active { true }

    trait :inactive do
      active { false }
    end

    trait :with_books do
      transient do
        books_count { 3 }
      end

      after(:create) do |author, evaluator|
        create_list(:book, evaluator.books_count, author: author)
      end
    end
  end
end
