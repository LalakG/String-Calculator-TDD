# string_calculator.rb

class StringCalculator
  def self.add(string_numbers)
    return 0 if string_numbers.empty?

    delimiter, string_numbers = extract_delimiter(string_numbers)
    parts = split_numbers(string_numbers, delimiter)
    integers = parts.map(&:to_i)

    raise_for_negatives(integers)

    integers.sum
  end

  private

  def self.extract_delimiter(string_numbers)
    if string_numbers.start_with?('//')
      parts = string_numbers.split("\n", 2)
      delimiter = extract_custom_delimiter(parts[0][2..-1])
      [delimiter, parts[1]]
    else
      [',', string_numbers]
    end
  end

  def self.extract_custom_delimiter(delimiter_part)
    if delimiter_part.start_with?('[') && delimiter_part.end_with?(']')
      delimiter_part.scan(/\[(.*?)\]/).map { |delim| Regexp.quote(delim[0]) }.join('|')
    else
      Regexp.quote(delimiter_part)
    end
  end

  def self.split_numbers(string_numbers, delimiter)
    string_numbers.split(/#{delimiter}|\n/)
  end

  def self.raise_for_negatives(integers)
    negatives = integers.select { |n| n < 0 }
    raise "Negative numbers not allowed: #{negatives.join(', ')}" unless negatives.empty?
  end
end
