FactoryBot.define do
  factory :comment do
    user_id 1
    body { Faker::Lorem.sentence(3, true) }
    movie_id 1
  end
end
