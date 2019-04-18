FactoryBot.define do
  factory :user do
  	password = "password"
  	
  	name { Faker::Name.name }
    email { Faker::Internet.email }
    encrypted_password { User.new(:password => password).encrypted_password }
  end
end