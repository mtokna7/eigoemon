FactoryBot.define do
  factory :quiz_choice do
    association :quiz
    furigana { 'くりぃく' }
    is_correct { true }
    bold_start { 1 }
    bold_end { 2 }
  end
end
