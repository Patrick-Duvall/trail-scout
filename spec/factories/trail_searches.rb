FactoryBot.define do
  factory :trail_search do
    sequence(:city) { |n| "city#{n}, co" }
    user factory: :user
  end
end
