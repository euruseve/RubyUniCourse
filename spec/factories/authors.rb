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
