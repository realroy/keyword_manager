FactoryBot.define do
  factory :keyword do
    word { Faker::Book.unique.title }
    total_link { (Random.rand * 10).round }
    total_adword { (Random.rand * total_link).round }
    total_result { (Random.rand * 1_000_000_000).round }
    total_search_time { Random.rand }
    html { nil }
  end
end
