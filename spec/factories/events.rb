FactoryGirl.define do
  factory :event do
    title { Faker::StarWars.planet }
    description { Faker::Hipster.paragraph(2) }
    address "MyString"
    lat 1.5
    lng 1.5

    after :build do |event, evaluator|
      event.shifts << FactoryGirl.build(:shift, event: nil)
    end

    trait :published do
      state 'published'
    end
  end
  factory :event_with_past_shift, class: Event do
    title { Faker::StarWars.planet }
    description { Faker::Hipster.paragraph(2) }
    state 'published'
    address "MyString"
    lat 1.5
    lng 1.5

    after :build do |event, evaluator|
      event.shifts << build(:shift, :past, event: nil)
    end
  end
  factory :event_with_full_shift, class: Event do
    title { Faker::StarWars.planet }
    description { Faker::Hipster.paragraph(2) }
    state 'published'
    address "MyString"
    lat 1.5
    lng 1.5

    after :build do |event, evaluator|
      event.shifts << build(:shift, :full, event: nil)
    end
  end
end
