FactoryBot.define do
  factory :trail_search do
    sequence(:city) { |n| "city#{n}, co" }
  end
end

# factory :user do
#   sequence(:email, 1000) { |n| "person#{n}@example.com" }
# end