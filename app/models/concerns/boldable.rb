module Boldable
  extend ActiveSupport::Concern

  def bold_range_exists?
    !bold_start.nil? && !bold_end.nil?
  end

  def parts
    if bold_range_exists?
      {first_part: furigana[0...bold_start], bold_part: furigana[bold_start...bold_end], last_part: furigana[bold_end..]}
    else
      {first_part: furigana, bold_part: nil, last_part: nil}
    end
  end
end
