FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    user { nil }
    article { nil }
  end
end
