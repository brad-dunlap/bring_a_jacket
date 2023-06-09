FactoryBot.define do
  factory :user do
    email {Faker::Internet.unique.email}
    password_digest { Faker::Internet.unique.password }
  end
end
