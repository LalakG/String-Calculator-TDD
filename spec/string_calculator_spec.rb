# spec/string_calculator_spec.rb

require './string_calculator'

RSpec.describe StringCalculator do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add("")).to eq(0)
    end

    it 'returns the number itself for a single number' do
      expect(StringCalculator.add("1")).to eq(1)
    end

    it 'returns the sum of comma-separated numbers' do
      expect(StringCalculator.add("1,5")).to eq(6)
    end

    it 'handles new lines between numbers' do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
    end

    it 'supports a single custom delimiter' do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
    end

    it 'raises an error for negative numbers' do
      expect { StringCalculator.add("1,-2") }.to raise_error("Negative numbers not allowed: -2")
    end

    it 'lists all negative numbers in the error message' do
      expect { StringCalculator.add("1,-2,-3") }.to raise_error("Negative numbers not allowed: -2, -3")
    end

    it 'returns the sum of multiple numbers' do
      expect(StringCalculator.add("1,2,3,4,5")).to eq(15)
    end

    it 'supports custom delimiter of any length' do
      expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
    end

    it 'supports multiple custom delimiters' do
      expect(StringCalculator.add("//[*][%]\n1*2%3")).to eq(6)
    end
  end
end
