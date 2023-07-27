class AddDefaultValueToIsCorrectInQuizChoices < ActiveRecord::Migration[7.0]
  def change
    change_column_default :quiz_choices, :is_correct, from: nil, to: false
  end
end
