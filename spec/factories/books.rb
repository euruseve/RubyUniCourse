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
