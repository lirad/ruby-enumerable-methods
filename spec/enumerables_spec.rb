require './enumerable.rb'

describe Enumerable do
  let(:array_integers) { (1..10).to_a }
  let(:array_strings) { %w[John Mary Douglas Michael] }
  let(:array_reduced) { 3_628_800 }
  let(:hash) { [{ 'Michael' => 2 }, { 'John' => 3 }] }
  let(:result) { [] }
  let(:compare) { [] }

  describe '#my_each' do
    it 'Return every element of an array of integers passing a block' do
      array_integers.my_each { |n| result << n + 1 }
      array_integers.each { |n| compare << n + 1 }
      expect(result).to eq(compare)
    end

    it 'Return every element of an array of strings' do
      array_strings.my_each { |n| result << n }
      array_strings.each { |n| compare << n }
      expect(result).to eq(compare)
    end

    it 'Return every element of a Hash' do
      hash.my_each { |n| result << n }
      hash.each { |n| compare << n }
      expect(result).to eq(compare)
    end
  end

  describe '#my_each_with_index' do
    it 'Return every element of an array of integers passing a block' do
      array_integers.my_each_with_index { |n| result << n + 1 }
      array_integers.each { |n| compare << n + 1 }
      expect(result).to eq(compare)
    end

    it 'Return every element of an array of strings' do
      array_strings.my_each_with_index { |n| result << n }
      array_strings.each { |n| compare << n }
      expect(result).to eq(compare)
    end

    it 'Return every element of a Hash' do
      hash.my_each_with_index { |_key, value| result << value + 2 }
      hash.each_with_index { |_key, value| compare << value + 2 }
      expect(result).to eq(compare)
    end
  end

  describe '#my_select' do
    it 'Checks if a element is selected from array' do
      result = array_integers.my_select { |n| n > 9 }
      compare = [10]
      expect(result).to eq(compare)
    end

    it 'Checks if a element is selected from array of strings' do
      result = array_strings.my_select { |n| n == 'John' }
      compare = ['John']
      expect(result).to eq(compare)
    end

    it 'Checks if a element is selected from a hash' do
      result = hash.my_select { |n| n['John'] }
      compare = hash.select { |n| n['John'] }
      expect(result).to eq(compare)
    end
  end

  describe '#my_all?' do
    it 'Checks for true if all elements matchs all the conditions' do
      result = array_strings.my_all?(array_strings)
      expect(result).to eq(true)
    end

    it 'Checks for false if all the conditions are not met' do
      result = array_strings.my_all?(%w[John Mary Douglas])
      expect(result).to eq(false)
    end
  end

  describe '#my_any?' do
    it 'Checks if returns true if any of the conditions are met' do
      result = array_strings.my_any?('John')
      compare = array_strings.any?('John')
      expect(result).to eq(compare)
    end
    it 'Checks if returns false if none of the conditions are met' do
      result = array_strings.my_any?('Pedro')
      compare = array_strings.any?('Pedro')
      expect(result).to eq(compare)
    end
  end

  describe '#my_none?' do
    it 'Checks if returns true if none of the conditions are met' do
      result = array_strings.my_none?('Pedro')
      expect(result).to eq(true)
    end

    it 'Checks if returns false if any of the conditions are met' do
      result = array_strings.my_none?('John')
      expect(result).to eq(false)
    end
  end

  describe '#my_count' do
    it 'Check if number of elements is equal to the passed object' do
      result = array_integers.my_count
      compare = array_integers.length
      expect(result).to eq(compare)
    end

    it 'Check if number of elements is equal to the passed conditon' do
      result = array_strings.my_count { |n| n == 'John' }
      compare = 1
      expect(result).to eq(compare)
    end
  end

  describe '#my_map' do
    proc = proc { |element| element }
    it 'Check if my map modifies the passed array' do
      result = array_integers.map { |n| n * 2 }
      expect(array_integers).not_to eq(result)
    end

    it 'Check if my_map work with procs' do
      expect(array_integers.my_map(&proc)).to eql(array_integers)
    end
  end

  describe '#my_inject' do
    proc = proc { |n, g| n * g }

    it 'Check if it works with a block ' do
      expect(array_integers.my_inject { |n, g| n * g }).to eql(array_reduced)
    end
    it 'Check if works with an argument' do
      expect(array_integers.my_inject(:*)).to eql(array_reduced)
    end
    it 'Check if it works with a proc' do
      expect(array_integers.my_inject(&proc)).to eql(array_reduced)
    end
  end
end

describe Multiply do
  let(:multiply) { Multiply.new }
  let(:array_integers) { (1..10).to_a }
  let(:array_reduced) { 3_628_800 }
  describe '#multiply_els' do
    it 'Check if returns the product of each element multiplied' do
      expect(multiply.multiply_els(array_integers)).to eql(array_reduced)
    end
  end
end
