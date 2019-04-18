FactoryBot.define do
  factory :commenter do
    comment_count rand(1..10)
    user_name "{ Faker::Lorem.name }"
  end
end