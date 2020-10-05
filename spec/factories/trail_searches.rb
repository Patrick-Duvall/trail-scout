FactoryBot.define do
  factory :trail_search do
    sequence(:city) { |n| "city#{n}, co" }
  end
end
