FactoryBot.define do
  factory :word do
    name { 'click' }
    programming_explanation { '...' } # こちらは省略していますが、実際のテキストを入れてください。
    english_explanation { '...' }
    furigana { 'くりぃく' }
    bold_start { 1 }
    bold_end { 2 }
  end
end
