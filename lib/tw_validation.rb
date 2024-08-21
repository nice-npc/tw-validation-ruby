# frozen_string_literal: true

require_relative "tw_validation/version"

module TwValidation
  class Error < StandardError; end

  # Id validator
  class Id
    def self.check(id)
      id = id.chars

      # ID should be 10 characters
      return false if id.length != 10

      # First letter should be English letter
      return false if id[0] !~ /[A-Z]/

      # Second letter should be 1 or 2
      return false if id[1] !~ /[12]/

      # 3-10 should be numbers
      return false if id[2..].any? { |v| v !~ /\d/ }

      # Checksum
      # rule: https://zh.wikipedia.org/zh-tw/%E4%B8%AD%E8%8F%AF%E6%B0%91%E5%9C%8B%E5%9C%8B%E6%B0%91%E8%BA%AB%E5%88%86%E8%AD%89#cite_note-51

      # Calculate checksum
      equal_value_map = ["A".."Z"].zip([1, 0, 9, 8, 7, 6, 5, 4, 9, 3, 2, 2, 1, 0, 8, 9, 8, 7, 6, 5, 4, 3, 1, 3, 2,
                                        0]).to_h
      id[0] = equal_value_map[id[0]]
      id = id.map(&:to_i)

      # (first letter + second letter * 8 + 3rd letter * 7 + ... + 9th letter * 1 + 10th letter * 1) % 10 == 0
      (id.each_with_index.sum { |v, i| v * (9 - i) } % 10).zero?
    end
  end
end
