module Boldable
  extend ActiveSupport::Concern

  def parts
    if bold_range_exists?
      {
        first_part: extract_substring(0, bold_start),
        bold_part: extract_substring(bold_start, bold_end),
        last_part: extract_substring(bold_end)
      }
    else
      { first_part: furigana, bold_part: nil, last_part: nil }
    end
  end

  private

  def extract_substring(start_index, end_index = nil)
    furigana[start_index...end_index]
  end

  def bold_range_exists?
    !bold_start.nil? && !bold_end.nil?
  end
end
