FactoryBot.define do
  factory :learning_datum do
    learning_subject { "MyString" }
    time { 1 }
    date { "2024-05-03" }
    user { nil }
    category { nil }
  end
end
